# Need gtools package for 'combinations' function to generate combination sets
require(gtools)

# Generate color table: color.table[i,j] is the color of edge ij, either 0 or 1, coded as FALSE or TRUE
# It is the cyclic coloring of K_17 where one color class is defined by {1,2,4,8,9,13,15,16}...
color.table <- outer( 0:16, 0:16, 
                      FUN=function(x,y) { 
                        apply(cbind(x,y), 1, function(x) abs(diff(x)) %in% c(1,2,4,8,9,13,15,16))
                        })

# Is complete bipartite subgraph formed by vertex sets x & y monochromatic? It would be if the slice of
# the color table is all true or all false. Note that no checking is done for disjointness of x & y.
monochrome.bipart <- function(x, y) {
  # The vertices are labeled 0 to 16, but R uses 1-based indexing in arrays, which is the purpose
  # of all the +1's
  all(color.table[x+1, y+1]) || all(!color.table[x+1,y+1])
}

# Is the complete graph defined by vertex set x monochromatic?
monochrome.complete <- function(x) {
  # See above for explanation of +1's.
  all(color.table[x+1,x+1]) || all(!color.table[x+1,x+1])
}

# NB: We use the symmetry of the cyclic coloring and always include 0 as one of the vertices considered,
# but we try all other combinations.

### FIRST CHECK: no monochromatic K_3,3

# Generate all pairs selected from {1,..., 16}
zr.pairs <- combinations(16, 2)

# Looping over each pair
for ( i in 1:nrow(zr.pairs) ) {
  
  # The pair is combined with zero to form a set of 3 vertices
  pair.and.zero <- c(0, zr.pairs[i,])
  
  # Now consider all triples of the remaining vertices
  left.over <- (1:16)[-zr.pairs[i,]]
  other.triples <- combinations(14, 3, v=left.over)

  # Loop over the other triples
  for ( j in 1:nrow(other.triples) ) {
    
    # Stop with failure if we find any of these K_3,3 subgraphs to be monochromatic
    if ( monochrome.bipart(pair.and.zero, other.triples[j,]) ) {
      stop(paste("Sorry: (", paste(paired.zeros, collapse=","),") and (", paste(other.triples[j,], collapse=","),
                 ") form a monochromatic K_3,3.", sep=""))
    }
    
  }
}

# SECOND CHECK: no monochromatic K_5,2

# Go over each vertex, pairing it with 0
for ( i in 1:16 ) {
  single.zeros <- c(0, i)
  
  # Now form all quintuples of the other vertices
  left.over <- (1:16)[-i]
  other.quints <- combinations(15, 5, v=left.over)
  
  # Loop over the quintuples
  for ( j in 1:nrow(other.quints) ) {
    
    # Stop with failure if we find any of these K_5,2 subgraphs to be monochromatic
    if ( monochrome.bipart(single.zeros, other.quints[j,]) ) {
      stop(paste("Sorry: (", paste(single.zeros, collapse=","),") and (", paste(other.quints[j,], collapse=","),
                 ") form a monochromatic K_5,2.", sep=""))
    }
    
  }
}

# THIRD CHECK: no monochromatic K_4

# Generate all triples
zr.triples <- combinations(16, 3)

for ( i in 1:nrow(zr.triples) ) {
  
  # Combine this with 0 for a quadruple
  triple.and.zero <- c(0, zr.triples[i,])
  
  if ( monochrome.complete(triple.and.zero) ) {
    stop(paste("Sorry: (", paste(single.zeros, collapse=","),") forms a monochromatic K_4.", sep=""))
  }
  
}

# If we've gotten this far, we've verified everything.
cat(paste("Success: no monochromatic K_3,3, K_5,2, or K_4 subgraphs found.\n"))

