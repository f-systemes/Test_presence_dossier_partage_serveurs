@ECHO off
TITLE Test de presence d'un dossier partage depuis une liste de serveur

REM Ce script test la présence d'un dossier partagé sur une serie de serveur présent

SET "listeNomServeur=%cd%\liste_serveurs.txt" REM Emplacement de la liste de serveur (1 serveur par ligne, ne pas mettre d'éspace dans le chemin)
SET "cheminDossier=\commun\ScanFTP" REM Dossier qui indique l'éxistance du scan to ftp sur le serveur
SET "FichierResultat=0" REM Création d'un fichier contenant les résultats; 0=non, 1=oui
SET "cheminFichierResultat=%cd%\resultat_testDossierPartageServeurs.txt" REM Emplacement du fichier de résultat. (%cd% donne l'emplacement de lancement du script)


IF NOT EXIST "%listeNomServeur%" (
	ECHO La liste des serveurs: "%listeNomServeur%" n'existe pas
	) ELSE (
	ECHO ^|-- Serveurs avec partage --^|
	IF "%FichierResultat%"=="1" ECHO ^|-- Serveurs avec partage --^| >"%cheminFichierResultat%"
	FOR /F %%l IN (%listeNomServeur%) DO (
		IF EXIST \\%%l"%cheminDossier%" (
			ECHO %%l
			IF "%FichierResultat%"=="1" ECHO %%l >>"%cheminFichierResultat%"
		)
	)
	
	ECHO
	ECHO ----------
	ECHO
	
	ECHO ^|-- Serveurs sans partage --^|
	IF "%FichierResultat%"=="1" ECHO ^|-- Serveurs sans partage --^| >>"%cheminFichierResultat%"
	FOR /F %%l IN (%listeNomServeur%) DO (
		IF NOT EXIST \\%%l"%cheminDossier%" (
			ECHO %%l
			IF "%FichierResultat%"=="1" ECHO %%l >>"%cheminFichierResultat%"
		)
	)
)
PAUSE