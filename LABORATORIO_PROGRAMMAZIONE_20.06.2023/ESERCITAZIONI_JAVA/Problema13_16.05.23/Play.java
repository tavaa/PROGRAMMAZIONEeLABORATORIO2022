/**
 * UniUd - Programmazione e laboratorio - 2022-23
 * 154255 - Tavano Matteo
 * Esercitazione 8 in Java
 */

import puzzleboard.*;
public class Play {
    
    public static void play(int n) {
        
        Board table = new Board(n);
        
        System.out.println(table.toString());
        while(!table.isOrdered()) {
            table.display();
            int value = table.get();
            if(table.isMovable(value)){
                System.out.println("yes "+value);
                table.move(value);
            } else {
                System.out.println("no "+value);
            }
            System.out.println(table.isOrdered());
        }
        
        System.out.println("You win");
    }
    
} // class Play
