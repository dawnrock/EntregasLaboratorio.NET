-- Laboratorio Extra

-- Listar las pistas ordenadas por el número de veces que aparecen en playlists de forma descendente


SELECT T.TrackId, T.[Name], COUNT(*) AS PlaylistsAmount
FROM dbo.Track T
	INNER JOIN dbo.PlaylistTrack PLT
	ON PLT.TrackId = T.TrackId
	INNER JOIN dbo.Playlist PL
	ON PL.PlaylistId = PLT.PlaylistId
GROUP BY T.TrackId, T.[Name]
ORDER BY COUNT(*) DESC  

-- Listar las pistas más compradas (la tabla InvoiceLine tiene los registros de compras)

SELECT T.TrackId, T.[Name] AS TrackName, A.[Name] AS ArtistName, AL.Title AS Album , COUNT(IL.TrackId) AS AmountSales
FROM dbo.Track T
	LEFT JOIN dbo.Album AL
	ON AL.AlbumId = T.AlbumId
	LEFT JOIN dbo.Artist A
	ON A.ArtistId = AL.ArtistId
	LEFT JOIN dbo.InvoiceLine IL
	ON IL.TrackId = T.TrackId
GROUP BY T.TrackId, T.[Name], IL.TrackId, A.[Name], AL.Title
HAVING COUNT(IL.TrackId) >= 2

-- Listar los artistas más comprados


SELECT  A.ArtistId, A.[Name] AS Artist, COUNT(IL.InvoiceLineId) AS Ventas
FROM dbo.Artist A
LEFT JOIN dbo.Album AL
	ON AL.ArtistId = A.ArtistId
LEFT JOIN dbo.Track T
	ON T.AlbumId = AL.AlbumId
LEFT JOIN dbo.InvoiceLine IL
	ON IL.TrackId = T.TrackId
GROUP BY A.ArtistId,A.[Name]
ORDER BY Ventas DESC


-- Listar las pistas que aún no han sido compradas por nadie

SELECT T.TrackId, T.[Name] AS TrackName
FROM dbo.Track T
	LEFT JOIN dbo.InvoiceLine IL
	ON IL.TrackId = T.TrackId
WHERE IL.TrackId IS NULL

-- Listar los artistas que aún no han vendido ninguna pista

SELECT  A.ArtistId, A.[Name] AS Artist, COUNT(IL.InvoiceLineId) AS Ventas
FROM dbo.Artist A
LEFT JOIN dbo.Album AL
	ON AL.ArtistId = A.ArtistId
LEFT JOIN dbo.Track T
	ON T.AlbumId = AL.AlbumId
LEFT JOIN dbo.InvoiceLine IL
	ON IL.TrackId = T.TrackId
GROUP BY A.ArtistId,A.[Name]
HAVING COUNT(IL.InvoiceLineId) = 0
ORDER BY A.ArtistId ASC

