/**
 * UniUd - Programmazione e laboratorio - 2022-2023
 * 154255 - Tavano Matteo
 * Esercitazione 8 in Java
 */

import puzzleboard.*;
public class Board {
    private final int dim;
    private final int[][] table;
    private final PuzzleBoard gui;
    private int posX,posY;
    
    public Board(int n) {
        
        dim=n;
        gui = new PuzzleBoard( n );
        table=new int[n][n];
        
        for(int i=0;i<dim;i++) {
            for(int j=0;j<dim;j++) {
                table[i][j]=(((i+1)%n)*n)+((j+1)%n)+1;
                if(table[i][j]==dim*dim) {
                    gui.clear(i+1,j+1);
                    posX=i+1;
                    posY=j+1;
                } else {
                    gui.setNumber(i+1,j+1,table[i][j]);
                }
            }
        }
        
    }
    
    public boolean isOrdered(){
        
        int i = 1;
        
        for(int x=0;x<dim;x++) {
            for(int y=0;y<dim;y++) {
                if(table[x][y]!=i){
                    return false;
                }
                i++;
            }
        }
        
        return true;
    }
    
    
    public boolean isMovable(int value){
        
        int i,j=0;
        boolean flag=true;
        
        for(i=0;i<dim && flag;i++){
            for(j=0;j<dim && flag;j++){
                if(table[i][j]==value){
                    flag=false;
                }
            }
        }
        
        System.out.println(flag+" "+j+" "+i);
        
        if(flag){
            return false;
        } else {
            return 
            ((i+1==posX || i-1==posX) && posY==j)^
            ((j+1==posY || j-1==posY) && posX==i);
        }
        
    }
    
    public String toString(){
        
        String rapr="( ";
        
        for(int i=0;i<dim;i++){
            rapr+="( "; 
            for(int j=0;j<dim;j++){
                rapr+=table[i][j]+" ";
            }
            rapr+=") ";
        }
        
        return rapr+") "+posX+" "+posY;
    }
    
    public void move(int value){
        
        int i,j=0;
        boolean flag=true;
        
        for(i=0;i<dim && flag;i++){
            for(j=0;j<dim && flag;j++){
                if(table[i][j]==value){
                    flag=false;
                }
            }
        }
        
        if(!flag){
            gui.setNumber(posX,posY,table[i-1][j-1]);
            gui.clear(i,j);
            table[posX-1][posY-1]=table[i-1][j-1];
            table[i-1][j-1]=dim*dim;
            posX=i;
            posY=j;
        }
        
    }
    
    public void display(){
        gui.display();
    }
    
    public int get(){
        return gui.get();
    }
} // Board