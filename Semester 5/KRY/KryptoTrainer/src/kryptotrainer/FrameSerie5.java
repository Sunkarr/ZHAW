package kryptotrainer;

import javax.swing.*;

import java.awt.*;
import java.awt.event.*;
import java.util.Random;

import mybiginteger.*;

/**
 * <p>Title: KryptoTrainer</p>
 * <p>Description: Übungsumgebung für das Wahlfach Kryptologie</p>
 * <p>Copyright: Copyright (c) 2006 / Samuel Beer</p>
 * <p>Company: Zürcher Hochschule Winterthur</p>
 * <p>Version 1.1: Umgeschrieben für Array Benutzung
 * @author Samuel Beer
 * @version 1.1
 */


public class FrameSerie5 extends JFrame implements ActionListener{

	  private static final long serialVersionUID = 1L;
	// Elemente des Frames
	  JPanel contentPane;
	  GridLayout gridLayoutContentPane = new GridLayout();
	  JMenuBar jMenuBar1 = new JMenuBar();
	  JPanel jPanel3 = new JPanel();

	// Elemente der MenuBar
	  JMenu jMenuDatei = new JMenu();
	  JMenuItem jMenuDateiSchliessen = new JMenuItem();
	  JLabel[] jLabelDatenSatz = new JLabel[5];
	  JTextField[] jTextFieldDatenSatz = new JTextField[5];
	  JLabel[] jLabelSchluessel = new JLabel[5];
	  JTextArea[] jTextAreaSchluessel = new JTextArea[5];

	// Elemente jPanel3
	  JButton jButtonEntschl = new JButton();
	  JLabel[] jLabelEntschl = new JLabel[5];
	  JTextArea[] jTextAreaEntschl = new JTextArea[5];

	// Variabeln, die zur Programmierschnittstelle gehören
	  BigInteger[] datenSatzUnverschl = new BigInteger[5];
	  BigInteger[] schluessel = new BigInteger[5];
	  BigInteger datenbankVerschl = new BigInteger("0");
	  BigInteger[] datenSatzEntschl = new BigInteger[5];
	  JTextField textField = new JTextField("1");
	  JLabel lblMaximalenExponentenBestimmen = new JLabel();
	  JLabel lblZahlZ = new JLabel();
	  JTextField textField_1 = new JTextField("1");
	  JLabel lblZahlN = new JLabel();
	  JButton btnStart = new JButton();
	  JTextField textField_2 = new JTextField();
	  JLabel lblFaktorFinden = new JLabel();
	  JTextField textField_3 = new JTextField("1");
	  JTextField textField_4 = new JTextField("1");
	  JTextField textField_5 = new JTextField();
	  JLabel lblZahlN_1 = new JLabel();
	  JLabel lblSchrankeB = new JLabel();
	  JLabel lblFaktor = new JLabel();
	  JLabel lblMaxESd = new JLabel();

	  public FrameSerie5() {
	  	getContentPane().setBackground(Color.WHITE);
		for(int i = 0; i< 5; i++){
			jLabelDatenSatz[i]= new JLabel();
			jTextFieldDatenSatz[i] = new JTextField();
			jLabelSchluessel[i] = new JLabel();
			jTextAreaSchluessel[i] = new JTextArea();
			jLabelEntschl[i] = new JLabel();
			jTextAreaEntschl[i] = new JTextArea();
			datenSatzUnverschl[i] = new BigInteger("0");
			schluessel[i]  = new BigInteger("0");
			datenSatzEntschl[i] = new BigInteger("0");
		}
	    try {
	      jbInit();
	    }
	    catch(Exception ex) {
	      ex.printStackTrace();
	    }
	  }

	  void jbInit() throws Exception {
	// Allgemeine Initialisierungen
	    this.setSize(new Dimension(600, 800));
	    this.setTitle("KryptoTrainer Testumgebung zum Praktikum 7");

	// Menu
	    jMenuDatei.setText("Datei");
	    jMenuDateiSchliessen.setText("Schliessen");
	    jMenuDateiSchliessen.addActionListener(this);	
	    jMenuDatei.add(jMenuDateiSchliessen);
	    jMenuBar1.add(jMenuDatei);
	    this.setJMenuBar(jMenuBar1);

	// Schriftart und Grösse für JTextArea Felder
	    Font font = new Font(Font.MONOSPACED, Font.PLAIN, 13);
	    
	    int[] recYLabelDatenSatz = {61, 85, 110, 134,158};
	    int[] recYTextFieldDatenSatz = {58, 82, 107, 131,155};
	  
	    int[] recYLabelSchluessel = {58, 80, 102, 124, 146};
	    for (int i=0; i<5; i++) {
	    	jLabelSchluessel[i].setText("Schlüssel "+(i+1));
	        jLabelSchluessel[i].setBounds(new Rectangle(383, recYLabelSchluessel[i], 145, 15));
	    }
	    int[] recYTextAreaSchluessel = {55, 77, 99, 121, 143};
	    for (int i=0; i<5; i++) {
		    jTextAreaSchluessel[i].setBounds(new Rectangle(9, recYTextAreaSchluessel[i], 370, 21));
		    jTextAreaSchluessel[i].setText("");
		    jTextAreaSchluessel[i].setEditable(false);
		    jTextAreaSchluessel[i].setBackground(Color.lightGray);
		    jTextAreaSchluessel[i].setFont(font);
	    }


	// Panel 3
	    jPanel3.setLayout(null);
	    jPanel3.setBackground(Color.WHITE);
	    jButtonEntschl.setText("Start");
	    jButtonEntschl.setBounds(new Rectangle(306, 184, 147, 25));
	    jButtonEntschl.addActionListener(this);
	    jPanel3.add(jButtonEntschl, null);
	    
	    int[] recYLabelEntschl = {80,102,124,146,168};
	    int[] recYTextAreaEntschl = {77,99,121,143,165};


	// ContentPane
	    contentPane = (JPanel) this.getContentPane();
	    contentPane.setMinimumSize(new Dimension(600, 800));
	    contentPane.setPreferredSize(new Dimension(600, 800));
	    gridLayoutContentPane.setColumns(1);
	    gridLayoutContentPane.setRows(3);
	    contentPane.setLayout(gridLayoutContentPane);
	    contentPane.add(jPanel3, null);
	    textField.setSelectionEnd(11);
	    textField.setHorizontalAlignment(SwingConstants.RIGHT);
	    textField.setBounds(new Rectangle(9, 51, 278, 21));
	    textField.setBounds(10, 39, 198, 21);
	    
	    jPanel3.add(textField);
	    lblMaximalenExponentenBestimmen.setText("Maximalen Exponenten bestimmen");
	    lblMaximalenExponentenBestimmen.setFont(new Font("Times New Roman", Font.BOLD, 15));
	    lblMaximalenExponentenBestimmen.setBounds(new Rectangle(10, 11, 270, 17));
	    lblMaximalenExponentenBestimmen.setBounds(10, 11, 270, 17);
	    
	    jPanel3.add(lblMaximalenExponentenBestimmen);
	    lblZahlZ.setText("Zahl z");
	    lblZahlZ.setBounds(new Rectangle(560, 444, 188, 15));
	    lblZahlZ.setBounds(218, 42, 188, 15);
	    
	    jPanel3.add(lblZahlZ);
	    textField_1.setSelectionEnd(11);
	    textField_1.setHorizontalAlignment(SwingConstants.RIGHT);
	    textField_1.setBounds(new Rectangle(9, 51, 278, 21));
	    textField_1.setBounds(10, 71, 198, 21);
	    
	    jPanel3.add(textField_1);
	    lblZahlN.setText("Zahl n");
	    lblZahlN.setBounds(new Rectangle(560, 444, 188, 15));
	    lblZahlN.setBounds(218, 74, 188, 15);
	    
	    jPanel3.add(lblZahlN);
	    btnStart.addActionListener(new ActionListener() {
	    	public void actionPerformed(ActionEvent e) {
	    		BigInteger z = new BigInteger(textField.getText());
	    		BigInteger r = new BigInteger(textField_1.getText());
	    		int i = z.findExp(r); 
	    		textField_2.setText(String.valueOf(i));
	    	}
	    });
	    btnStart.setText("Start");
	    btnStart.setBounds(new Rectangle(192, 211, 147, 25));
	    btnStart.setBounds(306, 64, 147, 25);
	    
	    jPanel3.add(btnStart);
	    textField_2.setEditable(false);
	    textField_2.setSelectionEnd(11);
	    textField_2.setHorizontalAlignment(SwingConstants.RIGHT);
	    textField_2.setBounds(new Rectangle(9, 51, 278, 21));
	    textField_2.setBounds(10, 103, 198, 21);
	    
	    jPanel3.add(textField_2);
	    lblFaktorFinden.setText("Faktor finden");
	    lblFaktorFinden.setFont(new Font("Times New Roman", Font.BOLD, 15));
	    lblFaktorFinden.setBounds(new Rectangle(10, 11, 270, 17));
	    lblFaktorFinden.setBounds(10, 135, 270, 17);
	    
	    jPanel3.add(lblFaktorFinden);
	    textField_3.setSelectionEnd(11);
	    textField_3.setHorizontalAlignment(SwingConstants.RIGHT);
	    textField_3.setBounds(new Rectangle(9, 51, 278, 21));
	    textField_3.setBounds(10, 163, 198, 21);
	    
	    jPanel3.add(textField_3);
	    textField_4.setSelectionEnd(11);
	    textField_4.setHorizontalAlignment(SwingConstants.RIGHT);
	    textField_4.setBounds(new Rectangle(9, 51, 278, 21));
	    textField_4.setBounds(10, 188, 198, 21);
	    
	    jPanel3.add(textField_4);
	    textField_5.setSelectionEnd(11);
	    textField_5.setHorizontalAlignment(SwingConstants.RIGHT);
	    textField_5.setEditable(false);
	    textField_5.setBounds(new Rectangle(9, 51, 278, 21));
	    textField_5.setBounds(10, 220, 198, 21);
	    
	    jPanel3.add(textField_5);
	    lblZahlN_1.setText("Zahl n");
	    lblZahlN_1.setBounds(new Rectangle(560, 444, 188, 15));
	    lblZahlN_1.setBounds(218, 166, 44, 15);
	    
	    jPanel3.add(lblZahlN_1);
	    lblSchrankeB.setText("Schranke B");
	    lblSchrankeB.setBounds(new Rectangle(560, 444, 188, 15));
	    lblSchrankeB.setBounds(218, 191, 62, 15);
	    
	    jPanel3.add(lblSchrankeB);
	    lblFaktor.setText("Faktor");
	    lblFaktor.setBounds(new Rectangle(560, 444, 188, 15));
	    lblFaktor.setBounds(218, 223, 62, 15);
	    
	    jPanel3.add(lblFaktor);
	    lblMaxESd.setText("max. e s.d. z^e < n");
	    lblMaxESd.setBounds(new Rectangle(560, 444, 188, 15));
	    lblMaxESd.setBounds(218, 106, 188, 15);
	    
	    jPanel3.add(lblMaxESd);
	  }
	  
	  public void actionPerformed( ActionEvent e ) {
		  	if (e.getSource() == jMenuDateiSchliessen)
		  		this.dispose();
		  	else {
		  		if (e.getSource() == jButtonEntschl)
		  		{
		  			BigInteger n = new BigInteger(textField_3.getText());
		  			BigInteger B = new BigInteger(textField_4.getText());
		  			BigInteger s = n.findFactor(B);
		  			textField_5.setText(s.toString());
		  		}
			}
		  }

}
