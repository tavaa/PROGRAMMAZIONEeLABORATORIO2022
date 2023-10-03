/**
 * UniUd - Programmazione e laboratorio - 2022-23
 * 154255 - Tavano Matteo
 * Esercitazione 6 in Java
 */

public class BottomUpLIS {


  // Length of Longest Increasing Subsequence (LLIS):
  // Programmazione dinamica bottom-up
  
  public static int llisDP( int[] s ) {
  
    int n = s.length;
    
    int[][] mem = new int[ n+1 ][ n+1 ];
    
    for ( int j=0; j<=n; j=j+1 ) {
    
      mem[n][j] = 0;
    }
    
    for ( int i=n-1; i>=0; i=i-1 ) {
      for ( int j=0; j<=n; j=j+1 ) {
        
        int t = ( j == n ) ? 0 : s[j];
        
        if ( s[i] <= t ) {          
          mem[i][j] = mem[i+1][j];
        } else {                          
          mem[i][j] = Math.max( 1+mem[i+1][i], mem[i+1][j] );
        }
      }
    }
    
    return mem[0][n];
  }
  
  
  // Longest Increasing Subsequence (LIS):
  // Programmazione dinamica bottom-up

  
  public static int[] lisDP( int[] s ) {
  
    int n = s.length;
    
    int[][] mem = new int[ n+1 ][ n+1 ];
    
    for ( int j=0; j<=n; j=j+1 ) {
    
      mem[n][j] = 0;
    }
    
    for ( int i=n-1; i>=0; i=i-1 ) {
      for ( int j=0; j<=n; j=j+1 ) {
        
        int t = ( j == n ) ? 0 : s[j];
        
        if ( s[i] <= t ) {          
          mem[i][j] = mem[i+1][j];
        } else {                          
          mem[i][j] = Math.max( 1+mem[i+1][i], mem[i+1][j] );
        }
    }}

    int m =  mem[0][n];
    
    int[] r = new int[ m ]; 
    
    int i = 0;
    int j = n;
    int z = 0;

    while ( mem[i][j] > 0 ) {
    
      int t = ( j == n ) ? 0 : s[j];
      
      if ( (1+mem[i+1][i] > mem[i+1][j]) && (s[i] > t) && (z < m) ) {
         r[z] = s[i]; 
         z++;
         j = i;
         i++;
      } else {
         i++; 
      }
    }
    
    return r;                // = LIS relativa alla sequenza s
  }

  
}  // class BottomUpLIS

