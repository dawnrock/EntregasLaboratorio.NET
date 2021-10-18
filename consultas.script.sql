-- Laboratorio Básico Consultas LemonMusic

-- Listar las pistas (tabla Track) con precio mayor o igual a 1€

Use LemonMusic;
GO

SELECT T.TrackId, 
T.[Name] AS TrackName, 
T.UnitPrice
FROM dbo.Track T
WHERE T.UnitPrice >= 1
ORDER BY [Name] ASC


-- Listar las pistas de más de 4 minutos de duración

SELECT T.TrackId,
T.[Name] AS TrackName
FROM dbo.Track T
WHERE T.Milliseconds >= 240000
ORDER BY [Name] ASC

-- Listar las pistas que tengan entre 2 y 3 minutos de duración

SELECT T.TrackId, 
T.[Name] AS TrackName
FROM dbo.Track T
WHERE T.Milliseconds BETWEEN 120000 AND 180000
ORDER BY [Name] ASC

-- Listar las pistas que uno de sus compositores (columna Composer) sea Mercury

SELECT T.TrackId, 
T.[Name] AS TrackName, 
T.Composer AS Composer
FROM dbo.Track T
WHERE T.Composer LIKE '%Mercury%'
ORDER BY [Name] ASC

-- Calcular la media de duración de las pistas (Track) de la plataforma

SELECT AVG(T.Milliseconds) AS DuracionMediaPlataforma
FROM dbo.Track T

-- Listar los clientes (tabla Customer) de USA, Canada y Brazil

SELECT 
C.CustomerId,
C.FirstName,
C.Country
FROM dbo.Customer C
WHERE C.Country IN ('USA', 'Canada', 'Brazil')
ORDER BY C.CustomerId ASC

-- Listar todas las pistas del artista 'Queen' (Artist.Name = 'Queen')

SELECT T.TrackId, 
T.[Name], 
AR.ArtistId,
AR.[Name]
FROM dbo.Track T
INNER JOIN  dbo.Album AL
 ON AL.AlbumId = T.AlbumId
INNER JOIN dbo.Artist AR
 ON AR.ArtistId = AL.ArtistId
 WHERE AR.[Name] = 'Queen'
 ORDER BY T.[Name] ASC

-- Listar las pistas del artista 'Queen' en las que haya participado como compositor David Bowie

SELECT AR.ArtistId, 
AR.[Name] AS NombreArtista, 
T.TrackId, T.[Name] AS NombreCancion, 
T.Composer AS NombreCompositor
FROM dbo.Artist AR
INNER JOIN  dbo.Album AL
	ON AL.ArtistId = AR.ArtistId
INNER JOIN dbo.Track T
	ON T.AlbumId = AL.AlbumId
WHERE AR.[Name] = 'Queen' AND T.Composer LIKE '%David Bowie%'

-- Listar las pistas de la playlist 'Heavy Metal Classic'

SELECT T.TrackId, 
T.[Name] AS NombreCancion, 
PL.PlaylistId, 
PL.[Name] AS NombreLista
FROM dbo.Track T
INNER JOIN dbo.PlaylistTrack PLT
	ON PLT.TrackId = T.TrackId
INNER JOIN dbo.Playlist PL
	ON PL.PlaylistId = PLT.PlaylistId
WHERE PL.[Name] = 'Heavy Metal Classic'


-- Listar las playlist junto con el número de pistas que contienen

SELECT PL.PlaylistId, 
PL.[Name] , 
COUNT(PLT.TrackId) AS TracksPorLista
FROM dbo.Playlist PL
LEFT JOIN dbo.PlaylistTrack PLT
	ON PLT.PlaylistId = PL.PlaylistId
LEFT JOIN dbo.Track T
	ON T.TrackId = PLT.TrackId 
GROUP BY PL.PlaylistId, PL.[Name]

-- Listar las playlist (sin repetir ninguna) que tienen alguna canción de AC/DC

SELECT DISTINCT PL.[Name] AS PlayListName, AR.[Name] AS ArtistName 
FROM dbo.Playlist PL
LEFT JOIN dbo.PlaylistTrack PLT
	ON PLT.PlaylistId = PL.PlaylistId
LEFT JOIN dbo.Track T
	ON T.TrackId = PLT.TrackId 
LEFT JOIN dbo.Album AL
	ON AL.AlbumId = T.AlbumId
LEFT JOIN dbo.Artist AR
	ON AR.ArtistId = AL.ArtistId
WHERE AR.[Name] = 'AC/DC'


-- Listar las playlist que tienen alguna canción del artista Queen, junto con la cantidad que tienen

SELECT PL.[Name] AS PlayListName, 
AR.[Name] AS ArtistName, 
COUNT(T.TrackId) AS TracksOnList
FROM dbo.Playlist PL
LEFT JOIN dbo.PlaylistTrack PLT
	ON PLT.PlaylistId = PL.PlaylistId
LEFT JOIN dbo.Track T
	ON T.TrackId = PLT.TrackId 
LEFT JOIN dbo.Album AL
	ON AL.AlbumId = T.AlbumId
LEFT JOIN dbo.Artist AR
	ON AR.ArtistId = AL.ArtistId
WHERE AR.[Name] = 'Queen'
GROUP BY PL.PlaylistId, PL.[Name],AR.[Name]

-- Listar las pistas que no estan en ninguna playlist

SELECT T.TrackId, T.[Name] AS NombreCancion, PLT.PlaylistId
FROM dbo.Track T
LEFT JOIN dbo.PlaylistTrack PLT
	ON PLT.TrackId = T.TrackId
WHERE PLT.PlaylistId IS NULL

-- Listar los artistas que no tienen album

SELECT A.ArtistId, A.[Name]
FROM dbo.Artist A
	LEFT JOIN dbo.Album AL
	ON AL.ArtistId = A.ArtistId
WHERE AL.AlbumId IS NULL

-- Listar los artistas con el número de albums que tienen

SELECT A.ArtistId, A.[Name], COUNT(AL.AlbumId) AS AmountAlbums
FROM dbo.Artist A
	LEFT JOIN dbo.Album AL
	ON AL.ArtistId = A.ArtistId
GROUP BY A.ArtistId, A.[Name]