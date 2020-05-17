# tri2seg <- function(x) {
#   out <- t(matrix(t(x)[matrix(c(1L, 2L,
#                          2L, 3L,
#                          3L, 1L) + rep(seq_len(dim(x)[1L])-1, each = 6L)
#                        , nrow = 2L), ], 2L))
#   colnames(out) <- c(".vx0", ".vx1")
#   out <- tibble::as_tibble(out)
#   out$path_ <- rep(x$path_, each = 3L)
#   out
# }
# SC0.TRI0 <- function(x) {
#   lapply(sc_object(x)$topology_, function(a)
#                                 tri2seg(as.matrix(a[c(".vx0", ".vx1", ".vx2")])))
#
#
# }


## UNFINISHED, can't get holes working in Tas mainland - works in mm though
library(basf)

library(silicate)
sf <- sfheaders::sf_cast(subset(inlandwaters, Province == "Tasmania"), "POLYGON")
#i <- i + 1
#plot(tasf <- sf[-order(st_area(sf))[i], ])
#tasf <- sf[-56, ]  ## Macquarie Island ## no duh can't do multi
tasf <- sf[which.max(st_area(sf)), ]

## just weighted centroid, it's enough for this data
tas_cent <- matrix(rapply(tasf$geom, colMeans, classes = "matrix"), ncol = 2, byrow = TRUE)
hole <- is.na(sp::over(sp::SpatialPoints(tas_cent), as_Spatial(st_set_crs(tasf, NA)))$Province)
if (any(hole)) {
  tas_cent <- tas_cent[hole, ]
}

plot(tasf)
abline(h = tas_cent[,2], v = tas_cent[,1])

mm_cent <- matrix(rapply(minimal_mesh$geom, colMeans, classes = "matrix"), ncol = 2, byrow = TRUE)

pslg0 <- function() {
  #RTriangle::pslg(cbind(0, 0))
  structure(list(P = structure(c(0, 0), .Dim = 1:2), PA = structure(numeric(0), .Dim = 1:0),
                 PB = 0L, S = structure(integer(0), .Dim = c(0L, 2L)), SB = integer(0),
                 H = structure(numeric(0), .Dim = c(0L, 2L))), class = "pslg")
}
as.pslg.sc <- function(x, H = NULL) {
  x <- SC0(x)
  seg <- do.call(rbind, x$object$topology_)
  p <- pslg0()
  p$P <- as.matrix(sc_vertex(x))
  p$S <- cbind(seg$.vx0, seg$.vx1)
  if (!is.null(H)) {
    if (!is.matrix(H) && dim(H)[2L] == 2L) {
        p$H <- H
      }
  }
  #plot(p); plot(RTriangle::triangulate(p))
  p
}

mm <- as.pslg.sc(SC0(minimal_mesh))
tas <- as.pslg.sc(SC0(tasf), H = tas_cent)
RTriangle:::plot.pslg(mm)
RTriangle:::plot.pslg(tas, pch = ".")
tastri <- RTriangle::triangulate(tas)
plot(NA, xlim = c(855232.8, 884623.2), ylim = c(-1127132, -1082308))
anglr::mesh_plot(anglr::as.mesh3d(tastri), add = TRUE, col = sample(viridis::viridis(20)))
plot(SC0(tasf), add = TRUE)

RTriangle:::plot.triangulation(tastri, pch = ".")
pryr::object_size(mm)
pryr::object_size(iw)
mm_tri <- triangulate(mm)
usethis::use_data(mm, tas, mm_tri, overwrite = TRUE, compress = "xz")
