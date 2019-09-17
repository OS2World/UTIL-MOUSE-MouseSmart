 /*
  * This program uses a semi-undefined mouse driver ioctl to change
  * the dynamic movement of that device.  I decided to try this after
  * browsing the DDSK CDROM source code for the mouse device driver,
  * where I saw this ioctl hidden away.  The structure that it uses
  * is,  however, documented in bsesub.h.
  *
  * Note that this program uses the ioctl defines for the Get/Set
  * "hotkey". It appears that these are no longer supported for that
  * function,  and are instead used to get/set the threshold
  * multiplier buffer.
  *
  * To change the mouse behavior of the OS/2 2.x PM desktop,  this
  * program must be run from a vio window.  It is a sample program
  * only,  with hard-coded values for the new multipliers.
  *
  * Peter Fitzsimmons, Thu  94-06-09
  *
  *
  *
  * Added some 'features':
  * - commandline parameter 
  * - syntax info.
  * - showing old and new values
  *
  * Works also with OS/2 WARP
  *
  * Andreas Just  March 1995
  *
  */

 
 //  ibm cset++:  icc /Ssem /Kb mou.c
 //               (use /Rn to make exe smaller)
 
 #define INCL_DOS
 #define INCL_NOPMAPI
 #define INCL_DOSDEVIOCTL
 #define INCL_MOU
 #include <os2.h>
 #include <stdio.h>
 #include <io.h>
 #include <fcntl.h>
 #include <assert.h>
 #include <string.h>
 #include <stdlib.h>
 

int main(int argc, char **argv)
 {
     int h;
     APIRET rc;
     ULONG ulParmLen;
     ULONG ulDataLen;
     THRESHOLD buf, new;
 
     h = open("/dev/MOUSE$", O_RDWR);
     if (h == -1) {
         printf("Mouse not installed!\n");
         exit(1);
     }

     memset(&buf, 0, sizeof(buf));
     buf.Length = sizeof(buf);
     ulParmLen  = 0;
     ulDataLen  = sizeof(buf);

     rc = DosDevIOCtl(h, IOCTL_POINTINGDEVICE,
                      MOU_GETHOTKEYBUTTON,
                      NULL, 0, &ulParmLen, &buf,
                      sizeof(buf), &ulDataLen);

     if (rc)
      {
       printf("sys%04u: get ioctl failed\n", rc);
       exit(1);
      }
     else  memcpy(&new, &buf, sizeof(buf));


     if (argc < 5)
      {
       printf("\n-------- NO / NOT ENOUGH COMMANDLINE PARAMETERS - USING DEFAULT VALUES ---------\n\n");
       printf("Syntax may be:\t MOUSPEED <a> <b> <c> <d>\n");
       printf("\t\t <a> = First movement level   <b> = First level multiplier\n");
       printf("\t\t <c> = Second movement level  <d> = Second level multiplier\n\n");
       printf("Sample:\t\t MOUSPEED 3 2 20 4     \"sets slow values\"\n");
       printf("       \t\t MOUSPEED 5 2 10 5     \"sets faster values\"\n");
       printf("--------------------------------------------------------------------------------\n\n");

       // set default values:
       new.Level1   = 5;
       new.Lev1Mult = 2;
       new.Level2   = 10;
       new.lev2Mult = 5;
      }
     else
      {
       // get commandline values
       *argv++; new.Level1   = atoi(*argv);
       *argv++; new.Lev1Mult = atoi(*argv);
       *argv++; new.Level2   = atoi(*argv);
       *argv++; new.lev2Mult = atoi(*argv);
      }

     printf("Old values:\t Level1    = %3d First movement level   \n", buf.Level1);
     printf("\t\t Lev1Mult  = %3d First level multiplier \n", buf.Lev1Mult);
     printf("\t\t Level2    = %3d Second movement level  \n", buf.Level2);
     printf("\t\t lev2Mult  = %3d Second level multiplier\n", buf.lev2Mult);
 
     ulParmLen = sizeof(new);
     ulDataLen = 0;

     rc = DosDevIOCtl(h, IOCTL_POINTINGDEVICE,
                      MOU_SETHOTKEYBUTTON,
                      &new, sizeof(new), &ulParmLen,
                      NULL, 0, &ulDataLen);
     if (rc) 
      {
       printf("sys%04u: set ioctl failed\n", rc);
       exit(1);
      }

     printf("New values:\t Level1    = %3d First movement level   \n", new.Level1);
     printf("\t\t Lev1Mult  = %3d First level multiplier \n", new.Lev1Mult);
     printf("\t\t Level2    = %3d Second movement level  \n", new.Level2);
     printf("\t\t lev2Mult  = %3d Second level multiplier\n", new.lev2Mult);

     close(h);
     return 0;
 }

