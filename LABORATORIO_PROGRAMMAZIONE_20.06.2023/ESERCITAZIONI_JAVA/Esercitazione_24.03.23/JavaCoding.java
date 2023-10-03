/**
 * UniUd - Programmazione e laboratorio - 2022-2023
 * 154255 - Tavano Matteo
 * Esercitazione 1 in Java
 * 
 * Traduzione esercizi scheme
 */
public class JavaCoding {
  
  /*
   * (define btr-succ                       ; val: stringa di -/./+
       (lambda (btr)                        ; btr: stringa di -/./+
         (let ((n (string-length btr)))     ; (brt = "." oppure inizia con "+")
           (let ((lsb (string-ref btr (- n 1))))
             (if (= n 1)
                 (if (char=? lsb #\+)
                     "+-"
                     "+")
                 (let ((pre (substring btr 0 (- n 1))))
                   (if (char=? lsb #\+)
                       (string-append (btr-succ pre) "-")
                       (string-append pre (if (char=? lsb #\-) "." "+"))
                       ))
                  )))
         ))
   */  
  
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
  
  
  /*
   * (define bit-complement   ; val: stringa
       (lambda (bit)          ; bit: stringa
         (if (string=? bit "0")
             "1"
             "0"
             )))

     (define ones-complement  ; val: stringa di 0/1
       (lambda (bin)          ; bin: stringa di 0/1
         (if (string=? bin "")
             ""
             (string-append
               (ones-complement (substring bin 0 (- (string-length bin) 1)))
               (bit-complement (substring bin (- (string-length bin) 1)))
               ))
          )) 
   */
  
  public static String onesComplementRec( String bin ) {
    
    if ( bin.equals( "" ) ) {
        return "";
    } else {
        String s = bin.substring( 0, bin.length()-1 );
        String str = bin.substring( bin.length()-1 );
        
        return onesComplementRec(s) + bitComplementRec(str);
    }
  }
  private static String bitComplementRec( String bit ) {
      
    if ( bit.equals( "0" ) ) {
        return "1";
    } else {
        return "0";
    }
  }
  
  // Iterative version
  
  public static String onesComplementIt( String bin ) {
    
    int n = bin.length();
    String s = "";
    
    for ( int i=0; i<n; i=i+1 ) {
        
        s = s + bitComplementIt( bin.charAt(i) );
    }
    return s;
  }
  private static String bitComplementIt( char bit ) {
      
    if ( bit == '0' ) {
        return "1";
    } else {
        return "0";
    }
  }

}
