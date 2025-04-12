/* -*- rexx -*-
 */

SAY "---- NYAOS �z�z�p�b�P�[�W���샆�[�e�B���e�B�[ ----"

"lxlite nyaos.exe"

/* DLL ���Ăяo�� */
CALL RxFuncAdd  SysFileTree, RexxUtil, SysFileTree
CALL RxFuncAdd  GetKey , RexxUtil , SysGetKey

/* readme.XXX �� XXX �����ɁA�o�[�W�����i���o�𒲂ׂ�B
 * �������钆�ŁA�ł��傫�� XXX ���̗p����B
 */

IF ARG()<1 | ARG(1)=="" THEN DO
    CALL SysFileTree "readme.*","list","FO"
    ver = -1
    DO i=1 TO list.0
	PARSE VAR list.i . "." suffix
	IF DATATYPE(suffix,"N") & suffix > ver THEN
	    ver = suffix
    END
    IF ver = -1 THEN DO 
	SAY "�o�|�W�����i���o�������ɕK�v�ł��B"
	EXIT 1
    END
END
ELSE DO 
    ver = ARG(1)
    IF POS(".",ver)<>0 THEN
	ver = DELSTR(ver,POS(".",ver),1)
END


readme_1st = "readme."||ver
IF stream( readme_1st ,"C","query exists") == "" THEN DO
    readme_1st = "README.1ST"
    IF stream( readme_1st , "C" ,"query exists" )=="" THEN DO 
	SAY "README."ver"�����݂��܂���B"
	EXIT 1
    END
END

major=LEFT(ver,1)
minor=SUBSTR(ver,2)

binpack = "nyaos"ver".lzh"
srcpack = "nyaos-"major"."minor".tar.bz2"

SAY "---- �o�C�i���p�b�P�[�W�쐬 ----"
"lha a" binpack readme_1st "nyaos.doc nyaosdoc.html nyaos.exe" ,
    "nyaos.rc nyaos1.ico nyaos2.ico nyaos-fc.ico nyaos-fo.ico",
	"history install.cmd"

SAY "---- �\�[�X�p�b�P�[�W�쐬 ----"
"make README1ST="readme_1st "nyaos.tar"
"bzip2 --compress --repetitive-best < nyaos.tar >" srcpack
"del nyaos.tar"

webdir = "..\..\www\my\warp"
SAY "�E�F�u�f�B���N�g��("webdir")�փR�s�[���܂����H"
IF GetKey() = 'y' THEN DO
    "copy" binpack webdir
    "copy" srcpack webdir
END
SAY

packdir = "..\package\nyaos"
SAY "�p�b�P�[�W�f�B���N�g��("packdir")�փR�s�[���܂����H"
if GetKey() = 'y' THEN DO 
    "copy" binpack packdir
    "copy" srcpack packdir
END
SAY

exit 0
