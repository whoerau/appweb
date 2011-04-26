/*
    cgiProgram.c - Test CGI program
  
    Copyright (c) All Rights Reserved. See details at the end of the file.

    Usage:
        cgiProgram [switches]
            -a                  Output the args (used for ISINDEX queries)
            -b bytes            Output content "bytes" long                 
            -e                  Output the environment 
            -h lines            Output header "lines" long
            -l location         Output "location" header
            -n                  Non-parsed-header ouput
            -p                  Ouput the post data
            -q                  Ouput the query data
            -s status           Output "status" header
            default             Output args, env and query
  
        Alternatively, pass the arguments as an environment variable HTTP_SWITCHES="-a -e -q"
 */

/********************************** Includes **********************************/

#define _CRT_SECURE_NO_WARNINGS 1

#include <errno.h>
#include <limits.h>
#include <stdarg.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#if _WIN32 || WINCE
#include <fcntl.h>
#include <io.h>
#include <windows.h>

	#define access   _access
	#define close    _close
	#define fileno   _fileno
	#define fstat    _fstat
	#define getpid   _getpid
	#define open     _open
	#define putenv   _putenv
	#define read     _read
	#define stat     _stat
	#define umask    _umask
	#define unlink   _unlink
	#define write    _write
	#define strdup   _strdup
	#define lseek    _lseek
	#define getcwd   _getcwd
	#define chdir    _chdir
	#define strnset  _strnset
	#define chmod    _chmod
	
	#define mkdir(a,b)  _mkdir(a)
	#define rmdir(a)    _rmdir(a)
#else
#include <unistd.h>
/* Just for VxWorks */
extern char *strdup(const char *);
#endif

/*********************************** Locals ***********************************/

#define MAX_ARGV                64
#define MPR_CMD_VXWORKS_EOF     "_ _EOF_ _"
#define MPR_CMD_VXWORKS_EOF_LEN 9

static char     *argvList[MAX_ARGV];
static int      getArgv(int *argc, char ***argv, int originalArgc, char **originalArgv);
static int      hasError;
static int      nonParsedHeader;
static int      numPostKeys;
static int      numQueryKeys;
static int      originalArgc;
static char     **originalArgv;
static int      outputArgs, outputEnv, outputPost, outputQuery;
static int      outputBytes, outputHeaderLines, responseStatus;
static char     *outputLocation;
static char     *postBuf;
static size_t   postBufLen;
static char     **postKeys;
static char     *queryBuf;
static size_t   queryLen;
static char     **queryKeys;
static char     *responseMsg;
static int      timeout;

/***************************** Forward Declarations ***************************/

static void     error(char *fmt, ...);
static void     descape(char *src);
static char     hex2Char(char *s); 
static int      getVars(char ***cgiKeys, char *buf, size_t len);
static int      getPostData(char **buf, size_t *len);
static int      getQueryString(char **buf, size_t *len);
static void     printEnv(char **env);
static void     printQuery();
static void     printPost(char *buf, size_t len);
static char     *safeGetenv(char *key);

/******************************************************************************/
/*
    Test program entry point
 */
int main(int argc, char *argv[], char *envp[])
{
    char    *cp, *method;
    int     i, j, err;

    err = 0;
    outputArgs = outputQuery = outputEnv = outputPost = 0;
    outputBytes = outputHeaderLines = responseStatus = 0;
    outputLocation = 0;
    nonParsedHeader = 0;
    responseMsg = 0;
    hasError = 0;
    timeout = 0;
    queryBuf = 0;
    queryLen = 0;
    numQueryKeys = numPostKeys = 0;

    originalArgc = argc;
    originalArgv = argv;

#if _WIN32 && !WINCE
    _setmode(0, O_BINARY);
    _setmode(1, O_BINARY);
    _setmode(2, O_BINARY);
#endif

    if (strstr(argv[0], "nph-") != 0) {
        nonParsedHeader++;
    }
    if (getArgv(&argc, &argv, originalArgc, originalArgv) < 0) {
        error("Can't read CGI input");
    }
    for (i = 1; i < argc; i++) {
        if (argv[i][0] != '-') {
            continue;
        }
        for (cp = &argv[i][1]; *cp; cp++) {
            switch (*cp) {
            case 'a':
                outputArgs++;
                break;

            case 'b':
                if (++i >= argc) {
                    err = __LINE__;
                } else {
                    outputBytes = atoi(argv[i]);
                }
                break;

            case 'e':
                outputEnv++;
                break;

            case 'h':
                if (++i >= argc) {
                    err = __LINE__;
                } else {
                    outputHeaderLines = atoi(argv[i]);
                    nonParsedHeader++;
                }
                break;

            case 'l':
                if (++i >= argc) {
                    err = __LINE__;
                } else {
                    outputLocation = argv[i];
                    if (responseStatus == 0) {
                        responseStatus = 302;
                    }
                }
                break;

            case 'n':
                nonParsedHeader++;
                break;

            case 'p':
                outputPost++;
                break;

            case 'q':
                outputQuery++;
                break;

            case 's':
                if (++i >= argc) {
                    err = __LINE__;
                } else {
                    responseStatus = atoi(argv[i]);
                }
                break;

            case 't':
                if (++i >= argc) {
                    err = __LINE__;
                } else {
                    timeout = atoi(argv[i]);
                }
                break;

            default:
                err = __LINE__;
                break;
            }
        }
    }
    if (err) {
        fprintf(stderr, "usage: cgiProgram -aenp [-b bytes] [-h lines]\n"
            "\t[-l location] [-s status] [-t timeout]\n"
            "\tor set the HTTP_SWITCHES environment variable\n");
        fprintf(stderr, "Error at cgiProgram:%d\n", __LINE__);
        exit(255);
    }

    method = getenv("REQUEST_METHOD") ;
    if (method == 0) {
        method = "GET";
    } else {
        if (strcmp(method, "POST") == 0) {
            if (getPostData(&postBuf, &postBufLen) < 0) {
                error("Can't read CGI input");
            }
            if (strcmp(safeGetenv("CONTENT_TYPE"), "application/x-www-form-urlencoded") == 0) {
                numPostKeys = getVars(&postKeys, postBuf, postBufLen);
            }
        }
    }

    if (hasError) {
        if (! nonParsedHeader) {
            printf("HTTP/1.0 %d %s\r\n\r\n", responseStatus, responseMsg);
            printf("<HTML><BODY><p>Error: %d -- %s</p></BODY></HTML>\r\n", responseStatus, responseMsg);
        }
        fprintf(stderr, "cgiProgram: ERROR: %s\n", responseMsg);
        exit(2);
    }

    if (nonParsedHeader) {
        if (responseStatus == 0) {
            printf("HTTP/1.0 200 OK\r\n");
        } else {
            printf("HTTP/1.0 %d %s\r\n", responseStatus, responseMsg ? responseMsg: "");
        }
        printf("Connection: close\r\n");
        printf("X-CGI-CustomHeader: Any value at all\r\n");
    }

    printf("Content-type: %s\r\n", "text/html");

    if (outputHeaderLines) {
        j = 0;
        for (i = 0; i < outputHeaderLines; i++) {
            printf("X-CGI-%d: A loooooooooooooooooooooooong string\r\n", i);
        }
    }

    if (outputLocation) {
        printf("Location: %s\r\n", outputLocation);
    }
    if (responseStatus) {
        printf("Status: %d\r\n", responseStatus);
    }
    printf("\r\n");

    if ((outputBytes + outputArgs + outputEnv + outputQuery + outputPost + outputLocation + responseStatus) == 0) {
        outputArgs++;
        outputEnv++;
        outputQuery++;
        outputPost++;
    }

    if (outputBytes) {
        j = 0;
        for (i = 0; i < outputBytes; i++) {
            putchar('0' + j);
            j++;
            if (j > 9) {
                if (++outputBytes > 0) {
                    putchar('\r');
                }
                if (++outputBytes > 0) {
                    putchar('\n');
                }
                j = 0;
            }
        }

    } 
    printf("<HTML><TITLE>cgiProgram: Output</TITLE><BODY>\r\n");
    if (outputArgs) {
#if _WIN32
        printf("<P>CommandLine: %s</P>\r\n", GetCommandLine());
#endif
        printf("<H2>Args</H2>\r\n");
        for (i = 0; i < argc; i++) {
            printf("<P>ARG[%d]=%s</P>\r\n", i, argv[i]);
        }
    }
    if (outputEnv) {
        printEnv(envp);
    }
    if (outputQuery) {
        printQuery();
    }
    if (outputPost) {
        printPost(postBuf, postBufLen);
    }
    printf("</BODY></HTML>\r\n");

#if VXWORKS
    /*
        VxWorks pipes need an explicit eof string
        Must not call exit(0) in Vxworks as that will exit the task before the CGI handler can cleanup. Must use return 0.
     */
    write(1, MPR_CMD_VXWORKS_EOF, MPR_CMD_VXWORKS_EOF_LEN);
    write(2, MPR_CMD_VXWORKS_EOF, MPR_CMD_VXWORKS_EOF_LEN);
#endif
    return 0;
}


/*
    If there is a HTTP_SWITCHES argument in the query string, examine that instead of the original argv
 */
static int getArgv(int *pargc, char ***pargv, int originalArgc, char **originalArgv)
{
    char    *switches, *next, sbuf[1024];
    int     i;

    *pargc = 0;
    if (getQueryString(&queryBuf, &queryLen) < 0) {
        return -1;
    }
    numQueryKeys = getVars(&queryKeys, queryBuf, queryLen);

    switches = 0;
    for (i = 0; i < numQueryKeys; i += 2) {
        if (strcmp(queryKeys[i], "HTTP_SWITCHES") == 0) {
            switches = queryKeys[i+1];
            break;
        }
    }

    if (switches == 0) {
        switches = getenv("HTTP_SWITCHES");
    }
    if (switches) {
        strncpy(sbuf, switches, sizeof(sbuf) - 1);
        descape(sbuf);
        next = strtok(sbuf, " \t\n");
        i = 1;
        for (i = 1; next && i < (MAX_ARGV - 1); i++) {
            argvList[i] = next;
            next = strtok(0, " \t\n");
        }
        argvList[0] = originalArgv[0];
        *pargv = argvList;
        *pargc = i;

    } else {
        *pargc = originalArgc;
        *pargv = originalArgv;
    }
    return 0;
}


static void printEnv(char **envp)
{
#if !VXWORKS && !WINCE
    printf("<H2>Environment Variables</H2>\r\n");
    printf("<P>AUTH_TYPE=%s</P>\r\n", safeGetenv("AUTH_TYPE"));
    printf("<P>CONTENT_LENGTH=%s</P>\r\n", safeGetenv("CONTENT_LENGTH"));
    printf("<P>CONTENT_TYPE=%s</P>\r\n", safeGetenv("CONTENT_TYPE"));
    printf("<P>DOCUMENT_ROOT=%s</P>\r\n", safeGetenv("DOCUMENT_ROOT"));
    printf("<P>GATEWAY_INTERFACE=%s</P>\r\n", safeGetenv("GATEWAY_INTERFACE"));
    printf("<P>HTTP_ACCEPT=%s</P>\r\n", safeGetenv("HTTP_ACCEPT"));
    printf("<P>HTTP_CONNECTION=%s</P>\r\n", safeGetenv("HTTP_CONNECTION"));
    printf("<P>HTTP_HOST=%s</P>\r\n", safeGetenv("HTTP_HOST"));
    printf("<P>HTTP_USER_AGENT=%s</P>\r\n", safeGetenv("HTTP_USER_AGENT"));
    printf("<P>PATH_INFO=%s</P>\r\n", safeGetenv("PATH_INFO"));
    printf("<P>PATH_TRANSLATED=%s</P>\r\n", safeGetenv("PATH_TRANSLATED"));
    printf("<P>QUERY_STRING=%s</P>\r\n", safeGetenv("QUERY_STRING"));
    printf("<P>REMOTE_ADDR=%s</P>\r\n", safeGetenv("REMOTE_ADDR"));
    printf("<P>REQUEST_METHOD=%s</P>\r\n", safeGetenv("REQUEST_METHOD"));
    printf("<P>REQUEST_URI=%s</P>\r\n", safeGetenv("REQUEST_URI"));
    printf("<P>REMOTE_USER=%s</P>\r\n", safeGetenv("REMOTE_USER"));
    printf("<P>SCRIPT_NAME=%s</P>\r\n", safeGetenv("SCRIPT_NAME"));
    printf("<P>SERVER_ADDR=%s</P>\r\n", safeGetenv("SERVER_ADDR"));
    printf("<P>SERVER_NAME=%s</P>\r\n", safeGetenv("SERVER_NAME"));
    printf("<P>SERVER_PORT=%s</P>\r\n", safeGetenv("SERVER_PORT"));
    printf("<P>SERVER_PROTOCOL=%s</P>\r\n", safeGetenv("SERVER_PROTOCOL"));
    printf("<P>SERVER_SOFTWARE=%s</P>\r\n", safeGetenv("SERVER_SOFTWARE"));

    printf("\r\n<H2>All Defined Environment Variables</H2>\r\n"); 
    if (envp) {
        char    *p;
        int     i;
        for (i = 0, p = envp[0]; envp[i]; i++) {
            p = envp[i];
            printf("<P>%s</P>\r\n", p);
        }
    }
    printf("\r\n");
#endif
}


static void printQuery()
{
    int     i;

    if (numQueryKeys == 0) {
        printf("<H2>No Query String Found</H2>\r\n");
    } else {
        printf("<H2>Decoded Query String Variables</H2>\r\n");
        for (i = 0; i < (numQueryKeys * 2); i += 2) {
            if (queryKeys[i+1] == 0) {
                printf("<p>QVAR %s=</p>\r\n", queryKeys[i]);
            } else {
                printf("<p>QVAR %s=%s</p>\r\n", queryKeys[i], queryKeys[i+1]);
            }
        }
    }
    printf("\r\n");
}

 
static void printPost(char *buf, size_t len)
{
    int     i;

    if (numPostKeys) {
        printf("<H2>Decoded Post Variables</H2>\r\n");
        for (i = 0; i < (numPostKeys * 2); i += 2) {
            printf("<p>PVAR %s=%s</p>\r\n", postKeys[i], postKeys[i+1]);
        }

    } else if (buf) {
        if (len < (50 * 1000)) {
            write(1, buf, len);
        } else {
            printf("<H2>Post Data %d bytes found</H2>\r\n", (int) len);
        }

    } else {
        printf("<H2>No Post Data Found</H2>\r\n");
    }
    printf("\r\n");
}


static int getQueryString(char **buf, size_t *buflen)
{
    *buflen = 0;
    *buf = 0;

    if (getenv("QUERY_STRING") == 0) {
        *buf = "";
        *buflen = 0;
    } else {
        *buf = getenv("QUERY_STRING");
        *buflen = (int) strlen(*buf);
    }
    return 0;
}


static int getPostData(char **bufp, size_t *lenp)
{
    char    *contentLength, *buf;
    size_t  bufsize, bytes, size, limit, len;

    if ((contentLength = getenv("CONTENT_LENGTH")) != 0) {
        size = atoi(contentLength);
        limit = size;
    } else {
        size = 4096;
        limit = INT_MAX;
    }
    if ((buf = malloc(size + 1)) == 0) {
        error("Couldn't allocate memory to read post data");
        return -1;
    }
    bufsize = size + 1;
    len = 0;

    while (len < limit) {
        if ((len + size + 1) > bufsize) {
            if ((buf = realloc(buf, len + size + 1)) == 0) {
                error("Couldn't allocate memory to read post data");
                return -1;
            }
            bufsize = len + size + 1;
        }
        bytes = read(0, &buf[len], size);
        if (bytes < 0) {
            error("Couldn't read CGI input %d", errno);
            return -1;
        } else if (bytes == 0) {
            /* EOF */
            if (contentLength && len != limit) {
                error("Missing content data (Content-Length: %s)", contentLength ? contentLength : "unspecified");
            }
            break;
        }
        len += bytes;
    }
    buf[len] = 0;
    *lenp = len;
    *bufp = buf;
    return 0;
}


static int getVars(char ***cgiKeys, char *buf, size_t buflen)
{
    char    **keyList;
    char    *eq, *cp, *pp;
    int     i, keyCount;

    /*
        Change all plus signs back to spaces
     */
    keyCount = (buflen > 0) ? 1 : 0;
    for (cp = buf; cp < &buf[buflen]; cp++) {
        if (*cp == '+') {
            *cp = ' ';
        } else if (*cp == '&') {
            keyCount++;
        }
    }

    if (keyCount == 0) {
        return 0;
    }

    /*
        Crack the input into name/value pairs 
     */
    keyList = malloc((keyCount * 2) * sizeof(char**));

    i = 0;
    for (pp = strtok(buf, "&"); pp; pp = strtok(0, "&")) {
        if ((eq = strchr(pp, '=')) != 0) {
            *eq++ = '\0';
            descape(pp);
            descape(eq);
        } else {
            descape(pp);
        }
        if (i < (keyCount * 2)) {
            keyList[i++] = pp;
            keyList[i++] = eq;
        }
    }
    *cgiKeys = keyList;
    return keyCount;
}


static char hex2Char(char *s) 
{
    char    c;

    if (*s >= 'A') {
        c = (*s & 0xDF) - 'A';
    } else {
        c = *s - '0';
    }
    s++;

    if (*s >= 'A') {
        c = c * 16 + ((*s & 0xDF) - 'A');
    } else {
        c = c * 16 + (*s - '0');
    }

    return c;
}


static void descape(char *src) 
{
    char    *dest;

    dest = src;
    while (*src) {
        if (*src == '%') {
            *dest++ = hex2Char(++src) ;
            src += 2;
        } else {
            *dest++ = *src++;
        }
    }
    *dest = '\0';
}


static char *safeGetenv(char *key)
{
    char    *cp;

    cp = getenv(key);
    if (cp == 0) {
        return "";
    }
    return cp;
}


void error(char *fmt, ...)
{
    va_list args;
    char    buf[4096];

    if (responseMsg == 0) {
        va_start(args, fmt);
        vsprintf(buf, fmt, args);
        responseStatus = 400;
        responseMsg = strdup(buf);
        va_end(args);
    }
    hasError++;
}


#if VXWORKS
/*
    VxWorks link resolution
 */
int _cleanup() {
    return 0;
}
int _exit() {
    return 0;
}
#endif /* VXWORKS */

/*
    @copy   default
  
    Copyright (c) Embedthis Software LLC, 2003-2011. All Rights Reserved.
    Copyright (c) Michael O'Brien, 1993-2011. All Rights Reserved.
  
    This software is distributed under commercial and open source licenses.
    You may use the GPL open source license described below or you may acquire
    a commercial license from Embedthis Software. You agree to be fully bound
    by the terms of either license. Consult the LICENSE.TXT distributed with
    this software for full details.
  
    This software is open source; you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by the
    Free Software Foundation; either version 2 of the License, or (at your
    option) any later version. See the GNU General Public License for more
    details at: http://www.embedthis.com/downloads/gplLicense.html
  
    This program is distributed WITHOUT ANY WARRANTY; without even the
    implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
  
    This GPL license does NOT permit incorporating this software into
    proprietary programs. If you are unable to comply with the GPL, you must
    acquire a commercial license to use this software. Commercial licenses
    for this software and support services are available from Embedthis
    Software at http://www.embedthis.com
  
    Local variables:
    tab-width: 4
    c-basic-offset: 4
    End:
    vim: sw=4 ts=4 expandtab

    @end
 */
