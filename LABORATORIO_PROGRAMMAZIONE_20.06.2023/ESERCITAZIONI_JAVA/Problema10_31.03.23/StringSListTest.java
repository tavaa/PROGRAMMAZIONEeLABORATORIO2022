/**
 * UniUd - Programmazione e laboratorio - 2022-23
 * 154255 - Tavano Matteo
 * Esercitazione 2 in Java
 */


public class StringSListTest {
    
    public static StringSList btrNot( String btr, int n ) { // btr notation
    
        StringSList l = new StringSList(); 
        String btrs = btr;
        
        for ( int i=0; i<n; i++) {
            
            l = l.cons( btr );
            btr = btrSucc(btr);
        }
        
        return l.reverse();
    }
    
    public static String btrSucc( String btr ) {
        
        int n = btr.length();
        char lsb = btr.charAt(n-1);
        String pre = btr.substring(0,n-1);
    
        if( n == 1 ) {
            if( lsb == ('+') ) {
                return "+-";
            } else {
                return "+";
            }
        } else if( lsb == ('+') ) {
            return btrSucc(pre) + "-";
        } else {
            return pre + (lsb == ('-') ? "." : "+");
        }
    }
    
    
} // class StringSListTest
