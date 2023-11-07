USE  [master]
GO
CREATE DATABASE Parcial2Pcdh
GO

CREATE LOGIN [usrparcial2] WITH PASSWORD = N'12345678',
	DEFAULT_DATABASE=[Parcial2Pcdh],
	CHECK_EXPIRATION=OFF,
	CHECK_POLICY=ON
GO

USE[Parcial2Pcdh] 
GO
CREATE USER [usrparcial2] FOR LOGIN [usrparcial2]
GO
ALTER ROLE [db_owner] ADD MEMBER [usrparcial2]
GO

DROP TABLE Serie
go


CREATE TABLE Serie (
	id INT IDENTITY (1,1) PRIMARY KEY,
	titulo VARCHAR (250 )NOT NULL,
	sinopsis VARCHAR(5000) NOT NULL,
	director VARCHAR(100) NOT NULL,
	duracion INT NOT NULL,
	fechaEstreno DATE NOT NULL,
	estado SMALLINT NOT NULL
)

ALTER TABLE Serie ADD usuarioRegistro VARCHAR(50) NOT NULL DEFAULT SUSER_NAME();
ALTER TABLE Serie ADD fechaRegistro DATETIME NOT NULL DEFAULT GETDATE();


CREATE PROC paSerieListar @parametro VARCHAR(50)
AS
	SELECT id,titulo, sinopsis, director,duracion,estado, fechaEstreno, usuarioRegistro
	FROM Serie
	Where estado <> -1 AND titulo LIKE '%'+ REPLACE (@parametro,' ','%')+'%';


SELECT * FROM serie