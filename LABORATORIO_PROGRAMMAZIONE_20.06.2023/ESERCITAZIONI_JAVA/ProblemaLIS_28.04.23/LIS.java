/**
 * UniUd - Programmazione e laboratorio - 2022-23
 * 154255 - Tavano Matteo
 * Esercitazione 5 in Java
 */

public class LIS {
    
  public static int llis( int[] s ) { // s[i] > 0 per i in [0,n-1], dove n = s.length
    
      return llisRec( s, 0, 0 );
  }
  public static int llisRec( int[] s, int i, int t ) {
    
      final int n = s.length;
    
      if ( i == n ) {                    // i = n : coda di s vuota
        return 0;
      } else if ( s[i] <= t ) {          // x = s[i] ≤ t : x non può essere scelto
        return llisRec( s, i+1, t );
      } else {                           // x > t : x può essere scelto o meno
        return Math.max( 1+llisRec(s,i+1,s[i]), llisRec(s,i+1,t) );
      }
  }
  /*
   llis( new int[] {5, 4, 3, 2, 1} ) → 1
   llis( new int[] {2, 7, 5, 7, 4} ) → 3
   llis( new int[] {47, 38, 39, 25, 44} ) → 3
   llis( new int[] {27, 90, 7, 29, 49, 8, 53, 1, 28, 6} ) → 4
   llis( new int[] {9, 46, 54, 71, 60, 47, 1, 32, 25, 61} ) → 5
   llis( new int[] {54, 52, 42, 33, 14, 40, 37, 61, 53, 1} ) → 3
   llis( new int[] {10, 8, 9, 5, 6, 7, 1, 2, 3, 4} ) → 4
   llis( new int[] {10, 11, 12, 6, 7, 8, 9, 1, 2, 3, 4, 5} ) → 5
   llis( new int[] {7, 8, 9, 10, 4, 5, 6, 2, 3, 1} ) → 4
   llis( new int[] {8, 9, 10, 11, 12, 4, 5, 6, 7, 1, 2, 3} ) → 5
   llis( new int[] {6, 1, 7, 2, 8, 3, 9, 4, 10, 5} ) → 5
   llis( new int[] {6, 1, 7, 2, 8, 3, 9, 4, 10, 5, 6} ) → 6
   */  
  
  /**
  1. Applicazione della tecnica top-down di memoization in situazioni semplificate
     Assumi provvisoriamente che tutti gli elementi di una sequenza di lunghezza n siano minori o ugali a n e scrivi un
     programma equivalente che applica la tecnica top-down di memoization per realizzare una versione più efficiente di
     llis, registrando i risultati delle invocazioni ricorsive di llisRec ai fini di un potenziale riutilizzo. Verifica quindi
     che i risultati ottenuti siano coerenti con i valori calcolati dal programma riportato sopra (a tal fine, una parte degli
     esempi non possono essere usati per la verifica poiché incompatibili con l’assunzione fatta).
  */
  public static int llisMem1 ( int[] s ) {
        
      int n = s.length;
      int[][] mem = new int[ n+1 ][ n+1 ];
        
      for(int i=0; i<=n; i=i+1) {
        for(int j=0; j<=n; j=j+1) {
            mem[i][j] = UNKNOWN;
        }
      }
        
      return llisMemRec1( s, 0, 0, mem); 
  }
  private static int llisMemRec1 ( int[] s, int i, int t, int[][] mem) {
    
      if ( mem[i][t] == UNKNOWN ) {
        if ( i == s.length ) {
            mem[i][t] = 0;
        } else if ( s[i] <= t ) {
            mem[i][t] = llisMemRec1( s, i+1, t, mem );
        } else {
            mem[i][t] = Math.max( 1+llisMemRec1(s,i+1,s[i], mem), llisMemRec1(s,i+1,t, mem) ) ;
        }
      }
      return mem[i][t];
  }
  private static final int UNKNOWN = -1; 
  
  /**
   2. Applicazione della tecnica top-down di memoization in casi più generali
      Estendi ora il programma che applica la tecnica top-down di memoization ai casi più generali in cui gli elementi della
      sequenza possano assumere qualunque valore intero (di tipo int) rappresentabile e verifica che i risultati ottenuti siano
      sempre coerenti con i valori calcolati dal programma riportato sopra.
      Suggerimento.
      - Poich� in generale il terzo argomento di llisRec può assumere valori molto grandi, non è ragionevole
      utilizzare i valori di t direttamente come indici di array, cosa che richiederebbe di allocare uno spazio in
      memoria di estensione esorbitante. Tuttavia è evidente che t è zero oppure è il valore di un elemento della
      sequenza s, nel qual caso lo si può rappresentare indirettamente attraverso la posizione di quella componente.
      - Inoltre, il caso t = 0 può essere a sua volta rappresentato indirettamente utilizzando un intero diverso dagli indici
      della sequenza, per esempio n (non appartiene [0, n-1]).
      - Alla luce delle osservazioni precedenti, al fine di rielaborare il programma attraverso una tecnica di
      memoization, si può sostituire il parametro della proceedura ricorsiva corrispondente a t (rappresentato
      direttamente) con un indice j compreso nell’intervallo [0, n] (che rappresenta t indirettamente). A partire
      dall’indice j sarà comunque possibile risalire facilmente al valore della soglia t, sulla base dell’interpretazione
      t = s[j] se 0 <= j < n, oppure t = 0 se j = n.
  */
  public static int llisMem2 (int[] s) {
        
      int n = s.length;
      int[][] mem = new int[ n+1 ][ n+1 ];
      for(int i=0; i<=n; i=i+1) {
        for(int j=0; j<=n; j=j+1) {
            mem[i][j] = UNKNOWN;
        }
      }  
      return llisRec2(s, 0, n, mem);
  }
  private static int llisRec2 (int[] s, int i, int j, int[][] mem) {
        
      int n = s.length;
      int m = 0; 
      if ((0 <= j) && (j < n)) {
        m = s[j];
      } else if (j == n) {
        m = 0; 
      }
      if ( mem[i][j] == UNKNOWN ) {
        if ( i == s.length ) {
            mem[i][j] = 0;
        } else if ( s[i] <= m ) {
            mem[i][j] = llisRec2( s, i+1, j, mem );
        } else {
            mem[i][j] =  Math.max( 1+llisRec2(s,i+1, i ,mem), llisRec2(s,i+1,j, mem) ) ;
        }
      }
      return mem[i][j];
  }
  
} // class LIS
