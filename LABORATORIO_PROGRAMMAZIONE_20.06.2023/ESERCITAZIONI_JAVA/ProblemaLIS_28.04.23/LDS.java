/**
 * UniUd - Programmazione e laboratorio - 2022-23
 * 154255 - Tavano Matteo
 * Esercitazione 7 in Java
 */

public class LDS {
  
  /**
   1. Sottosequenza decrescente pi� lunga
      Questo problema si formula in termini analoghi a quello della sottosequenza crescente più lunga, salvo che, come
      indicato dalla denominazione, gli elementi considerati devono costituire una sottosequenza strettamente decrescente,
      anzich� crescente, nel rispetto dell'ordine in cui compaiono in s.
      Modifica e/o integra il programma riportato sopra e scrivi un corrispondente programma ricorsivo per determinare la
      lunghezza della sottosequenza decrescente pi� lunga (llds).
  */ 
  public static int llis( int[] s ) { // s[i] > 0 per i in [0,n-1], dove n = s.length
    
    return llisRec( s, 0, 0 );
  }
  public static int llisRec( int[] s, int i, int t ) {
    
    final int n = s.length;
    
    if ( i == n ) {                    // i = n : coda di s vuota
      return 1;
    } else if ( s[i] >= t ) {          // x = s[i] ≤ t : x non può essere scelto
      return llisRec( s, i+1, s[i] );
    } else {                           // x > t : x può essere scelto o meno
      return Math.max( 1+llisRec(s,i+1,s[i]), llisRec(s,i+1,t) );
    }
  }
 
  private static int valoreMax( int[] s ) {   
        
    int max = 0;    
    for (int i = 0; i < s.length; i++) {
      max = (s[i] > max) ? s[i] : max;
    }
    return max;
  }
    
  public static int llds(int[] s) {
    return lldsRec(s, 0, valoreMax(s));
  }
    
  private static int lldsRec(int[] s, int i, int t) {
    if (i == s.length) {
      return 0;
    } else if (s[i] > t) {
      return lldsRec(s, i + 1, t);
    } else {
      return Math.max(1 + lldsRec(s, i + 1, s[i]), lldsRec(s, i + 1, t));
    }
  }

  
  /**
   2. Applicazione della tecnica di programmazione dinamica bottom-up
      Riutilizza il codice del programma che risolve il problema proposto al punto 2 dell’esercitazione del 5/05/2021
      (Progetto “Longest Increasing Subsequence�? – II), apportandovi le opportune modifiche e/o integrazioni, per
      determinare una sottosequenza decrescente più lunga (lds). Il programma deve avere una struttura analoga a quella
      impostata nell’esercitazione precedente, suddivisa in una prima fase per registrare in una matrice i risultati delle
      ricorsioni relative al programma originale, seguita da una seconda fase che consente di ricostruire una soluzione
      attraverso un percorso fra gli elementi della matrice.
   */
  public static int[] ldsDP(int[] s) {

    int n = s.length;
    
    int[][] mem = new int[n + 1][n + 1];

    for (int j = 0; j <= n; j++) {
      mem [n][j] = 0;           
    }
    
    for (int i = n - 1; i >= 0; i--) {   
      for (int j = 0; j <= n; j++) {   

        int t = 0; 

        if ((0 <= j) && (j < n)) {
          t = s[j];
        } else if (j == n) {
          t = 0;
        }
              
        if (s[i] >= t && t != 0) {
          mem[i][j] = mem[i+1][j];
        } else {
          mem[i][j] = Math.max(1 + mem [i+1][i], mem [i+1][j]);
        }
              
      }
    }

    int m = mem[0][n];

    int[] r = new int[m]; 
      
    int i = 0; 
    int j = n; 
    int k = 0; 
    
    while (mem[i][j] > 0) {
              
      int t = (j == n) ? 0 : s[j];

      if ((mem[i+1][i] + 1 > mem[i+1][j])) {  
                
        if(s[i] <= t || j == n) {  
                    
          r[k] = s[i];   
          k++;           
          j = i;         
          i++;           
                    
        } else {  
          i++;          
        }        
      } else {  
        i++;               
      }     
    }
    return r;         
  }
  

} // class LDS
