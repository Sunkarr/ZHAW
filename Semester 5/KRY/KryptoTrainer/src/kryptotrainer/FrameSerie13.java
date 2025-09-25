package kryptotrainer;
import java.lang.*;
import java.util.*;
import java.io.*;
import javax.swing.*;
import java.awt.*;
import java.awt.event.*;
import mybiginteger.*;

/**
 * <p>Title: KryptoTrainer</p>
 * <p>Description: Übungsumgebung für das Wahlfach Kryptologie</p>
 * <p>Copyright: Copyright (c) 2006 / Samuel Beer</p>
 * <p>Company: Zürcher Hochschule Winterthur</p>
 * @author Samuel Beer
 * @version 1.0
 */


/**
 * Programmierschnittstelle
 * ========================
 *
 * Variabeln: 
 * ----------
 *
 *   p: Primzahl für GF(p)
 *   a, b: Parameter der elliptischen Kurve
 *   P: ausgewählter Punkt der elliptischen Kurve 
 *   kA: geheimer Schlüssel von Alice
 *   kB: geheimer Schlüssel von Bob
 *   M: zu verschlüsselnde Nachricht, repräsentiert als Punkt der elliptischen Kurve
 *   m: zu verschlüsselnde Nachricht, repräsentiert als BigInteger
 *      
 *    
 */




public class FrameSerie13
    extends JFrame {

// Klassenvariablen
  private BigInteger primZahl_p = new BigInteger("3");
  private BigInteger parameter_a = new BigInteger("1");
  private BigInteger parameter_b = new BigInteger("1");
  private BigInteger punkt_x = new BigInteger("0");
  private BigInteger punkt_y = new BigInteger("0");
  private BigInteger punkt_y1 = punkt_y;
  private BigInteger punkt_y2 = punkt_y;
  private BigInteger faktor_n = new BigInteger("1");
  private BigInteger parameter_kA = new BigInteger("1");
  private BigInteger parameter_kB = new BigInteger("2");
  private BigInteger m_x = new BigInteger("1");
  private BigInteger m_y = new BigInteger("2");
  private BigInteger m_y1 = m_y;
  private BigInteger m_y2 = m_y;
  private BigInteger B_x = new BigInteger("-1");
  private BigInteger B_y = new BigInteger("-1");
  private BigInteger C_x = new BigInteger("-1");
  private BigInteger C_y = new BigInteger("-1");
  private BigInteger M = new BigInteger("-1");
  
  ElGamalEllipt encryptSystem = new ElGamalEllipt();

// Elemente des Frames
  JPanel contentPane;
  GridLayout gridLayoutContentPane = new GridLayout();
  JMenuBar jMenuBar1 = new JMenuBar();
  JPanel jPanel1 = new JPanel();

// Elemente der MenuBar
  JMenu jMenuDatei = new JMenu();
  JMenuItem jMenuDateiSchliessen = new JMenuItem();

// Elemente jPanel1
  JButton jButtonStartA = new JButton();
  JLabel jLabelTitel = new JLabel();
  JLabel jLabelUntertitelA = new JLabel();
  JLabel jLabelUntertitelB = new JLabel();
  JLabel jLabelUntertitelC = new JLabel();
  JLabel jLabelUntertitelD = new JLabel();
  JLabel jLabelPrimzahl_p = new JLabel();
  JLabel jLabelParameter_a = new JLabel();
  JLabel jLabelParameter_kA = new JLabel();
  JLabel jLabelParameter_kB = new JLabel();
  JLabel jLabel_m_y = new JLabel();
  JLabel jLabelResultat = new JLabel();
  JTextField jTextFieldPrimZahl_p = new JTextField();
  JTextField jTextFieldParameter_a = new JTextField();
  JTextField jTextFieldParameter_kA = new JTextField();
  JTextField jTextFieldParameter_kB = new JTextField();
  JTextField jTextField_m_y = new JTextField();
  JTextPane jTextPaneresultat_B_x = new JTextPane();
  JTextPane jTextPaneresultat_C_x = new JTextPane();
  JTextField jTextFieldParameter_b = new JTextField();
  JLabel jLabelParameter_b = new JLabel();
  JTextField jTextFieldPunkt_x = new JTextField();
  JTextField jTextField_m_x = new JTextField();
  JTextField jTextField_Nachricht_M = new JTextField();
    JLabel jLabelPunkt_y = new JLabel();
  JLabel jLabelPunkt_x = new JLabel();
  JLabel jLabel_m_x = new JLabel();
  JLabel jLabelFaktor_n = new JLabel();
  JTextPane jTextPaneresultat_B_y = new JTextPane();
  JLabel jLabelresultat_B_y = new JLabel();
  JTextPane jTextPaneresultat_C_y = new JTextPane();
  JLabel jLabelresultat_C_y = new JLabel();
  JLabel jLabelresultat_B_x = new JLabel();
  JLabel jLabelresultat_C_x = new JLabel();
    JTextPane jTextPanePunkt_y2 = new JTextPane();
    JTextPane jTextPanePunkt_y1 = new JTextPane();
    JTextPane jTextPane_m_y2 = new JTextPane();
    JTextPane jTextPane_m_y1 = new JTextPane();
    JRadioButton jRadioButtonPunkt_y1 = new JRadioButton();
    JRadioButton jRadioButtonPunkt_y2 = new JRadioButton();
    JRadioButton jRadioButton_m_y1 = new JRadioButton();
    JRadioButton jRadioButton_m_y2 = new JRadioButton();
    
    
    JTextPane textPane_entsch_m_x = new JTextPane();
    JTextPane textPane_entsch_m_y = new JTextPane();
    private final JButton button_verschl_M = new JButton();
    private final JButton button_entsch_M = new JButton();
    private final JTextPane textPane_entsch_M = new JTextPane();
    private final JLabel lblM = new JLabel();



    public FrameSerie13() {
    try {
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
// Allgemeine Initialisierungen
    this.setSize(new Dimension(853, 849));
    this.setTitle("KryptoTrainer Testumgebung zum Praktikum 14.2");
    gridLayoutContentPane.setRows(1);

// Menu
    jMenuDatei.setText("Datei");
    jMenuDateiSchliessen.setText("Schliessen");
    jMenuDateiSchliessen.addActionListener(new
                                           MyFrameSerie13_jMenuDateiSchliessen_actionAdapter(this));
        jTextPanePunkt_y2.setBackground(Color.lightGray);
        jTextPanePunkt_y2.setBorder(BorderFactory.createEtchedBorder());
        jTextPanePunkt_y2.setEditable(false);
        jTextPanePunkt_y2.setText("");
        jTextPanePunkt_y2.setBounds(new Rectangle(9, 174, 278, 21));   //285
        jTextPanePunkt_y1.setBackground(Color.lightGray);
        jTextPanePunkt_y1.setBorder(BorderFactory.createEtchedBorder());
        jTextPanePunkt_y1.setEditable(false);
        jTextPanePunkt_y1.setText("");
        jTextPanePunkt_y1.setBounds(new Rectangle(9, 147, 278, 21));   //258
        jTextFieldPunkt_x.setBounds(new Rectangle(9, 121, 278, 21));  //232
        jRadioButtonPunkt_y1.setText("");
        jRadioButtonPunkt_y1.setBounds(new Rectangle(289, 144, 19, 27));  //255
        jRadioButtonPunkt_y1.addActionListener(new
                                        MyFrameSerie13_jRadioButtonPunkt_y1_actionAdapter(this));
        jRadioButtonPunkt_y2.setText("");
        jRadioButtonPunkt_y2.setBounds(new Rectangle(289, 171, 19, 27));  //282
        jRadioButtonPunkt_y2.addActionListener(new
                                        MyFrameSerie13_jRadioButtonPunkt_y2_actionAdapter(this));
        jRadioButtonPunkt_y1.setSelected(true);
        
        jTextPane_m_y2.setBackground(Color.lightGray);
        jTextPane_m_y2.setBounds(new Rectangle(9, 370, 278, 21));   //285
        jTextPane_m_y2.setEditable(false);
        jTextPane_m_y2.setText("");
        jTextPane_m_y2.setBounds(new Rectangle(9, 370, 278, 21));   //285
        
        jTextPane_m_y1.setBackground(Color.lightGray);
        jTextPane_m_y1.setBorder(BorderFactory.createEtchedBorder());
        jTextPane_m_y1.setEditable(false);
        jTextPane_m_y1.setText("");
        jTextPane_m_y1.setBounds(new Rectangle(9, 347, 278, 21));   //258
        
        jTextField_m_x.setBounds(new Rectangle(9, 324, 278, 21));  //232
        
        jRadioButton_m_y1.setText("");
        jRadioButton_m_y1.setBounds(new Rectangle(289, 345, 19, 27));  //255
        jRadioButton_m_y1.addActionListener(new MyFrameSerie13_jRadioButton_m_y1_actionAdapter(this));
         jRadioButton_m_y2.setText("");
         jRadioButton_m_y2.setBounds(new Rectangle(289, 368, 19, 27));  //282
        jRadioButton_m_y2.addActionListener(new MyFrameSerie13_jRadioButton_m_y2_actionAdapter(this));
        jRadioButton_m_y1.setSelected(true);
        
        
        textPane_entsch_m_x.setText("");
        textPane_entsch_m_x.setEditable(false);
        textPane_entsch_m_x.setBounds(new Rectangle(9, 347, 278, 21));
        textPane_entsch_m_x.setBorder(BorderFactory.createEtchedBorder());
        textPane_entsch_m_x.setBackground(Color.LIGHT_GRAY);
        textPane_entsch_m_x.setBounds(9, 614, 278, 21);
        
        textPane_entsch_m_y.setText("");
        textPane_entsch_m_y.setEditable(false);
        textPane_entsch_m_y.setBounds(new Rectangle(9, 347, 278, 21));
        textPane_entsch_m_y.setBorder(BorderFactory.createEtchedBorder());
        textPane_entsch_m_y.setBackground(Color.LIGHT_GRAY);
        textPane_entsch_m_y.setBounds(9, 646, 278, 21);
        

        jMenuDatei.add(jMenuDateiSchliessen);

    jMenuBar1.add(jMenuDatei);
    this.setJMenuBar(jMenuBar1);

// Panel 1
    jPanel1.setLayout(null);
    jPanel1.setBackground(Color.white);
    jButtonStartA.setText("Verschlüsseln");
    jButtonStartA.setBounds(new Rectangle(115, 402, 112, 25));
    jButtonStartA.addActionListener(new MyFrameSerie13_jButtonStartA_actionAdapter(this));
    jLabelTitel.setFont(new java.awt.Font("Times New Roman", 1, 19));
    jLabelTitel.setHorizontalAlignment(SwingConstants.LEFT);
    jLabelTitel.setHorizontalTextPosition(SwingConstants.LEADING);
    jLabelTitel.setText("Testumgebung zur El Gamal Verschlüsselung mit elliptischen Kurven");
    jLabelTitel.setBounds(new Rectangle(1, 1, 564, 23));
    jLabelUntertitelA.setText("a) Grundkörper und Parameter der elliptischen Kurve");
    jLabelUntertitelA.setBounds(new Rectangle(9, 29, 420, 17));
    jLabelUntertitelA.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelPrimzahl_p.setText("Primzahl p für GF(p)");
    jLabelPrimzahl_p.setBounds(new Rectangle(291, 54, 188, 15));
    jLabelParameter_a.setBounds(new Rectangle(291, 78, 188, 15));
    jLabelParameter_a.setText("Parameter a");
    
    jLabelUntertitelB.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelUntertitelB.setText("b) Private Schlüssel");
    jLabelUntertitelB.setBounds(new Rectangle(9, 210, 391, 17));  //184
    jLabelParameter_kA.setBounds(new Rectangle(291, 240, 288, 15));  //188
    jLabelParameter_kA.setText("Parameter kA  (geheimer Schl\u00FCssel von Alice)");
    jLabelParameter_kB.setBounds(new Rectangle(291, 264, 288, 15)); 
    jLabelParameter_kB.setText("Parameter kB  (geheimer Schl\u00FCssel von Bob)");
  
    jLabelUntertitelC.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelUntertitelC.setText("c) Nachricht als Punkt auf der elliptischen Kurve");
    jLabelUntertitelC.setBounds(new Rectangle(9, 304, 391, 17));  //184
    jLabelUntertitelD.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelUntertitelD.setText("d) Nachricht als Zahl");
    jLabelUntertitelD.setBounds(new Rectangle(510, 304, 391, 17));  //184
    jLabelResultat.setText("Verschlüsselung als Element");
    jLabelResultat.setBounds(new Rectangle(330, 418, 278, 15));
    
    jLabel_m_y.setBounds(new Rectangle(318, 360, 209, 15));   //273
    jLabel_m_y.setText("Wahl der y-Komponente von M");
    jLabel_m_x.setText("x-Komponente von M");
    jLabel_m_x.setBounds(new Rectangle(291, 327, 209, 15));  //235
    
    jTextFieldPrimZahl_p.setBounds(new Rectangle(9, 51, 278, 21));
    jTextFieldPrimZahl_p.setText(primZahl_p.toString());
    jTextFieldPrimZahl_p.addActionListener(new
                                      MyFrameSerie13_jTextFieldPrimZahl_p_actionAdapter(this));
    jTextFieldPrimZahl_p.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldPrimZahl_p.setSelectionEnd(11);
    jTextFieldPrimZahl_p.setNextFocusableComponent(null);
    jTextFieldParameter_a.setText(parameter_a.toString());
    jTextFieldParameter_a.setNextFocusableComponent(null);
    jTextFieldParameter_a.setSelectionEnd(11);
    jTextFieldParameter_a.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldParameter_a.addActionListener(new
                                      MyFrameSerie13_jTextFieldParameter_a_actionAdapter(this));
    jTextFieldParameter_a.setBounds(new Rectangle(9, 75, 278, 21));
    
    jTextFieldParameter_kA.setText(parameter_kA.toString());
    jTextFieldParameter_kA.setSelectionEnd(11);
    jTextFieldParameter_kA.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldParameter_kA.addActionListener(new
                                      MyFrameSerie13_jTextFieldParameter_kA_actionAdapter(this));
    jTextFieldParameter_kA.setBounds(new Rectangle(9, 238, 278, 21));  
    jTextFieldParameter_kB.setText(parameter_kB.toString());
    jTextFieldParameter_kB.setSelectionEnd(11);
    jTextFieldParameter_kB.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldParameter_kB.addActionListener(new
                                      MyFrameSerie13_jTextFieldParameter_kB_actionAdapter(this));
    jTextFieldParameter_kB.setBounds(new Rectangle(9, 262, 278, 21));
    
    jTextPaneresultat_B_x.setBackground(Color.lightGray);
    jTextPaneresultat_B_x.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneresultat_B_x.setEditable(false);
    jTextPaneresultat_B_x.setBounds(new Rectangle(272, 444, 278, 21));
    jTextPaneresultat_C_x.setBackground(Color.lightGray);
    jTextPaneresultat_C_x.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneresultat_C_x.setEditable(false);
    jTextPaneresultat_C_x.setBounds(new Rectangle(272, 500, 278, 21));
    jTextFieldParameter_b.setBounds(new Rectangle(9, 98, 278, 21));
    jTextFieldParameter_b.addActionListener(new MyFrameSerie13_jTextFieldParameter_b_actionAdapter(this));
    jTextFieldParameter_b.addActionListener(new
                                      MyFrameSerie13_jTextFieldParameter_b_actionAdapter(this));
    jTextFieldParameter_b.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldParameter_b.setSelectionEnd(11);
    jTextFieldParameter_b.setNextFocusableComponent(null);
    jTextFieldParameter_b.setText(parameter_b.toString());
    jLabelParameter_b.setText("Parameter b");
    jLabelParameter_b.setBounds(new Rectangle(291, 101, 188, 15));
        jTextFieldPunkt_x.addActionListener(new
                                      MyFrameSerie13_jTextFieldPunkt_x_actionAdapter(this));
    jTextFieldPunkt_x.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldPunkt_x.setSelectionEnd(11);
    jTextFieldPunkt_x.setNextFocusableComponent(null);
    jTextFieldPunkt_x.setText(punkt_x.toString());
    
    jTextField_m_x.addActionListener(new
            MyFrameSerie13_jTextField_m_x_actionAdapter(this));
    jTextField_m_x.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextField_m_x.setSelectionEnd(11);
    jTextField_m_x.setNextFocusableComponent(null);
    jTextField_m_x.setText(m_x.toString());
    
    jTextField_Nachricht_M.setNextFocusableComponent(null);
    jTextField_Nachricht_M.setSelectionEnd(11);
    jTextField_Nachricht_M.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextField_Nachricht_M.addActionListener(new
                                      MyFrameSerie13_jTextFieldFaktor_n_actionAdapter(this));
    jTextField_Nachricht_M.setText(faktor_n.toString());
    jTextField_Nachricht_M.setBounds(new Rectangle(520, 324, 142, 21));
    jLabelPunkt_y.setBounds(new Rectangle(318, 162, 209, 15));   //273
    jLabelPunkt_y.setText("Wahl der y-Komponente von P");
    jLabelPunkt_x.setText("x-Komponente von P");
    jLabelPunkt_x.setBounds(new Rectangle(291, 127, 209, 15));  //235
    jLabelFaktor_n.setBounds(new Rectangle(672, 327, 58, 15));   //285
    jLabelFaktor_n.setText("m");
    jTextPaneresultat_B_y.setBounds(new Rectangle(272, 468, 278, 21));
    jTextPaneresultat_B_y.setEditable(false);
    jTextPaneresultat_B_y.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneresultat_B_y.setBackground(Color.lightGray);
    jLabelresultat_B_y.setBounds(new Rectangle(560, 468, 188, 15));
    jLabelresultat_B_y.setText("y-Komponente von B");
    jLabelresultat_B_x.setText("x-Komponente von B");
    jLabelresultat_B_x.setBounds(new Rectangle(560, 444, 188, 15));
    jTextPaneresultat_C_y.setBounds(new Rectangle(272, 532, 278, 21));
    jTextPaneresultat_C_y.setEditable(false);
    jTextPaneresultat_C_y.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneresultat_C_y.setBackground(Color.lightGray);
    jLabelresultat_C_y.setBounds(new Rectangle(560, 532, 188, 15));
    jLabelresultat_C_y.setText("y-Komponente von C");
    jLabelresultat_C_x.setText("x-Komponente von C");
    jLabelresultat_C_x.setBounds(new Rectangle(560, 494, 188, 15));
    
    
 
    jPanel1.add(textPane_entsch_m_x);
    

    jPanel1.add(textPane_entsch_m_y);

    jPanel1.add(jLabelTitel, null);
    jPanel1.add(jLabelUntertitelA, null);
    jPanel1.add(jTextFieldPrimZahl_p, null);
    jPanel1.add(jLabelPrimzahl_p, null);
    jPanel1.add(jTextFieldParameter_a, null);
    jPanel1.add(jTextFieldParameter_b, null);
    jPanel1.add(jLabelParameter_a, null);
    jPanel1.add(jLabelParameter_b, null);
    jPanel1.add(jLabelUntertitelB, null);
    jPanel1.add(jTextField_Nachricht_M, null);
    jPanel1.add(jTextFieldPunkt_x, null);
        jPanel1.add(jTextPaneresultat_B_x, null);
        jPanel1.add(jTextPaneresultat_C_x, null);
        jPanel1.add(jButtonStartA, null);
        jPanel1.add(jLabelResultat, null);
        jPanel1.add(jTextPaneresultat_B_y, null);
        jPanel1.add(jLabelresultat_B_x, null);
        jPanel1.add(jTextPaneresultat_C_y, null);
        jPanel1.add(jLabelresultat_C_x, null);
        jPanel1.add(jLabelresultat_B_y, null);
        jPanel1.add(jLabelresultat_C_y, null);
        jPanel1.add(jTextPanePunkt_y1);
        jPanel1.add(jTextPanePunkt_y2);
        jPanel1.add(jRadioButtonPunkt_y1);
        jPanel1.add(jRadioButtonPunkt_y2);
        jPanel1.add(jLabelPunkt_x, null);
        jPanel1.add(jLabelFaktor_n, null);
        jPanel1.add(jLabelPunkt_y, null);
        
    jPanel1.add(jTextFieldParameter_kA, null);
    jPanel1.add(jTextFieldParameter_kB, null);
    jPanel1.add(jLabelParameter_kA, null);
    jPanel1.add(jLabelParameter_kB, null);
    jPanel1.add(jTextField_m_x, null);
    

    jPanel1.add(jTextPane_m_y1);
    jPanel1.add(jTextPane_m_y2);
    jPanel1.add(jRadioButton_m_y1);
    jPanel1.add(jRadioButton_m_y2);
    jPanel1.add(jLabel_m_x, null);
    jPanel1.add(jLabel_m_y, null);
 jPanel1.add(jLabelUntertitelC, null);
 jPanel1.add(jLabelUntertitelD, null);

        // ContentPane
    contentPane = (JPanel)this.getContentPane();
    contentPane.setMinimumSize(new Dimension(600, 800));
    contentPane.setPreferredSize(new Dimension(600, 800));
    gridLayoutContentPane.setColumns(1);
    contentPane.setLayout(gridLayoutContentPane);

    contentPane.add(jPanel1, null);
    
    JButton jButtonStartB = new JButton();
    jButtonStartB.addActionListener(new ActionListener() {
    	public void actionPerformed(ActionEvent e) {
    		
    		BigInteger[] result = {new BigInteger("1"), new BigInteger("1")};
    		updateFields();
    		if (B_x.compareTo(BigInteger.ONE.negate()) == 0)  //noch nichts eingetragen
    		{
    			textPane_entsch_m_x.setText("Verschluesselung benoetigt");
    			textPane_entsch_m_y.setText("");
    		}
    		else
    		{
    		BigInteger[] B = {B_x, B_y};
    		BigInteger[] C = {C_x, C_y};
    		//BigInteger[] B = {jTextPaneresultat_B_x.getText(), jTextPaneresultat_B_y.getText()};
    		//BigInteger[] C = {jTextPaneresultat_C_x.getText(), jTextPaneresultat_C_y.getText()};
    		try {
				result = encryptSystem.elliptDecrypt(B, C);
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
    		if (m_x.compareTo(primZahl_p) == 0)
    		{
       			textPane_entsch_m_x.setText("unendlich ferner Punkt O");
        		textPane_entsch_m_y.setText("");
    		}
    		else	
    		{
    			textPane_entsch_m_x.setText(result[0].toString());
        		textPane_entsch_m_y.setText(result[1].toString());
    		}

    		}	
    	}
    });
    jButtonStartB.setText("Entschlüsseln");
    jButtonStartB.setBounds(new Rectangle(348, 398, 112, 25));
    jButtonStartB.setBounds(115, 578, 112, 25);
    jPanel1.add(jButtonStartB);
    
    JLabel lblXkomponenteVonM = new JLabel();
    lblXkomponenteVonM.setText("x-Komponente von M");
    lblXkomponenteVonM.setBounds(new Rectangle(291, 454, 188, 15));
    lblXkomponenteVonM.setBounds(291, 620, 188, 15);
    jPanel1.add(lblXkomponenteVonM);
    
    JLabel lblYkomponenteVonM = new JLabel();
    lblYkomponenteVonM.setText("y-Komponente von M");
    lblYkomponenteVonM.setBounds(new Rectangle(291, 454, 188, 15));
    lblYkomponenteVonM.setBounds(291, 646, 188, 15);
    jPanel1.add(lblYkomponenteVonM);
    button_verschl_M.addActionListener(new ActionListener() {
    	public void actionPerformed(ActionEvent e) {
    		
    		BigInteger[] result = {new BigInteger("0"), new BigInteger("1"), new BigInteger("0"), new BigInteger("1")};
    		BigInteger[]  B = {new BigInteger("1"), new BigInteger("1")};
    		BigInteger[]  C = {new BigInteger("1"), new BigInteger("1")};
    		updateFields();
    		BigInteger[] A = {new BigInteger("1"), new BigInteger("1")};	
    		
    		
    		if (! (punkt_y.equals(BigInteger.ONE.negate())))
    	    {
    	        try 
    	        {
    	        	A =  punkt_x.elliptMultiply(punkt_y, parameter_kA, primZahl_p, parameter_a, parameter_b);  	    	
    	          //res = punkt_x.elliptMultiply(punkt_y, faktor_n, primZahl_p, parameter_a, parameter_b);
    	        	BigInteger[] P = {punkt_x, punkt_y};
    	        	result = encryptSystem.messageEncrypt(M);
    	            B[0] = result[0];
    	            B[1] = result[1];
    	            C[0] = result[2];
    	            C[1] = result[3];
    	            
    	            
    	            // Unendlich ferner Punkt: B = (p,*)
    	            if (result[0].equals(primZahl_p)) 
    	            {
    	                jTextPaneresultat_B_x.setText("Unendlich ferner Punkt O");
    	                jTextPaneresultat_B_y.setText("");
    	            }
    	            else
    	            {
    	                jTextPaneresultat_B_x.setText(B[0].toString());
    	                jTextPaneresultat_B_y.setText(B[1].toString());
    	            }
    	            
    	            if (C[0].equals(primZahl_p)) 
    	            {
    	                jTextPaneresultat_C_x.setText("Unendlich ferner Punkt O");
    	                jTextPaneresultat_C_y.setText("");
    	            }
    	            else
    	            {
    	                jTextPaneresultat_C_x.setText(C[0].toString());
    	                jTextPaneresultat_C_y.setText(C[1].toString());
    	            }
    	            B_x = B[0];
    	            B_y = B[1];
    	            C_x = C[0];
    	            C_y = C[1];
    	          
    	        }
    	        catch (Exception ex) {
    	          jTextPaneresultat_B_x.setText(ex.getMessage());
    	          jTextPaneresultat_B_y.setText("");
    	        }
    	    }
    	    else 
    	    {
    	        jTextPaneresultat_B_x.setText("");
    	        jTextPaneresultat_B_y.setText("");
    	        jTextPaneresultat_C_x.setText("");
    	        jTextPaneresultat_C_y.setText("");
    	    } 
    	}
    });
    button_verschl_M.setText("Verschl\u00FCsseln");
    button_verschl_M.setBounds(new Rectangle(348, 398, 112, 25));
    button_verschl_M.setBounds(530, 356, 112, 25);
    
    jPanel1.add(button_verschl_M);
    button_entsch_M.addActionListener(new ActionListener() {
    	public void actionPerformed(ActionEvent e) {
    		
    		BigInteger result = new BigInteger("-1");
    		textPane_entsch_M.setText("");
    		updateFields();
    		
    		if (B_x.compareTo(BigInteger.ONE.negate()) == 0)  //noch nichts eingetragen
    		{
    			textPane_entsch_M.setText("Verschluesselung benoetigt");
    		}
    		else
    		{
    		BigInteger[] B = {B_x, B_y};
    		BigInteger[] C = {C_x, C_y};
    		//BigInteger[] B = {jTextPaneresultat_B_x.getText(), jTextPaneresultat_B_y.getText()};
    		//BigInteger[] C = {jTextPaneresultat_C_x.getText(), jTextPaneresultat_C_y.getText()};
    		try {
				result = encryptSystem.messageDecrypt(B, C);
			} catch (Exception e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
    		textPane_entsch_M.setText(result.toString());
    		}	
    		
    	}
    });
    button_entsch_M.setText("Entschl\u00FCsseln");
    button_entsch_M.setBounds(new Rectangle(348, 398, 112, 25));
    button_entsch_M.setBounds(550, 578, 112, 25);
    
    jPanel1.add(button_entsch_M);
    textPane_entsch_M.setText("");
    textPane_entsch_M.setEditable(false);
    textPane_entsch_M.setBounds(new Rectangle(9, 347, 278, 21));
    textPane_entsch_M.setBorder(BorderFactory.createEtchedBorder());
    textPane_entsch_M.setBackground(Color.LIGHT_GRAY);
    textPane_entsch_M.setBounds(530, 620, 155, 21);
    
    jPanel1.add(textPane_entsch_M);
    lblM.setText("m");
    lblM.setBounds(new Rectangle(291, 684, 209, 15));
    lblM.setBounds(696, 620, 34, 15);
    
    jPanel1.add(lblM);
    

    }

  void jButtonStartA_actionPerformed(ActionEvent e) 
  {
    BigInteger[] result = {new BigInteger("1"), new BigInteger("1"), new BigInteger("1"), new BigInteger("1")};
    BigInteger[] A = {new BigInteger("1"), new BigInteger("1")};
    BigInteger[] B = {new BigInteger("1"), new BigInteger("1")};
    BigInteger[] C = {new BigInteger("1"), new BigInteger("1")};
    BigInteger[] M = {new BigInteger("1"), new BigInteger("1")};
    BigInteger[] P = {new BigInteger("1"), new BigInteger("1")};
    
    updateFields();

    // Testberechnungen
    if (! (punkt_y.equals(BigInteger.ONE.negate())) || (m_y.equals(BigInteger.ONE.negate())))
    {
        try 
        {
        	A =  punkt_x.elliptMultiply(punkt_y, parameter_kA, primZahl_p, parameter_a, parameter_b);
        	M[0] = m_x;
        	M[1] = m_y;
        	P[0] = punkt_x;
        	P[1] = punkt_y;
          //res = punkt_x.elliptMultiply(punkt_y, faktor_n, primZahl_p, parameter_a, parameter_b);
        	result = encryptSystem.elliptEncrypt(M);
            B[0] = result[0];
            B[1] = result[1];
            C[0] = result[2];
            C[1] = result[3];

            
            // Unendlich ferner Punkt: B = (p,*)
            if (B[0].equals(primZahl_p)) 
            {
                jTextPaneresultat_B_x.setText("Unendlich ferner Punkt O");
                jTextPaneresultat_B_y.setText("");
            }
            else
            {
                jTextPaneresultat_B_x.setText(B[0].toString());
                jTextPaneresultat_B_y.setText(B[1].toString());
            }
            
            if (C[0].equals(primZahl_p)) 
            {
                jTextPaneresultat_C_x.setText("Unendlich ferner Punkt O");
                jTextPaneresultat_C_y.setText("");
            }
            else
            {
                jTextPaneresultat_C_x.setText(C[0].toString());
                jTextPaneresultat_C_y.setText(C[1].toString());
            }
            B_x = B[0];
            B_y = B[1];
            C_x = C[0];
            C_y = C[1];
          
        }
        catch (Exception ex) {
          jTextPaneresultat_B_x.setText(ex.getMessage());
          jTextPaneresultat_B_y.setText("");
        }
    }
    else 
    {
        jTextPaneresultat_B_x.setText("");
        jTextPaneresultat_B_y.setText("");
        jTextPaneresultat_C_x.setText("");
        jTextPaneresultat_C_y.setText("");
    } 
  }

  void jMenuDateiSchliessen_actionPerformed(ActionEvent e) {
    this.dispose();
  }

  void jTextFieldPrimZahl_p_actionPerformed(ActionEvent e) {
    updateFields();
    jTextFieldPrimZahl_p.selectAll();
  }

  void jTextFieldParameter_a_actionPerformed(ActionEvent e) {
    updateFields();
    jTextFieldParameter_a.selectAll();
  }

  void jTextFieldParameter_b_actionPerformed(ActionEvent e) {
    updateFields();
    jTextFieldParameter_b.selectAll();
  }

  void jTextFieldFaktor_n_actionPerformed(ActionEvent e) {
    updateFields();
    jTextField_Nachricht_M.selectAll();
  }

  void jTextFieldPunkt_x_actionPerformed(ActionEvent e) {
    updateFields();
    jTextFieldPunkt_x.selectAll();
  }
  
  void jTextField_m_x_actionPerformed(ActionEvent e) {
	    updateFields();
	    jTextField_m_x.selectAll();
	  }
  
  void jTextFieldParameter_kA_actionPerformed(ActionEvent e) {
	    updateFields();
	    jTextFieldParameter_kA.selectAll();
	  }
  
  
  void jTextFieldParameter_kB_actionPerformed(ActionEvent e) {
	    updateFields();
	    jTextFieldParameter_kB.selectAll();
	  }
  


  void updateFields() {
    primZahl_p = new BigInteger(jTextFieldPrimZahl_p.getText());
    parameter_a = new BigInteger(jTextFieldParameter_a.getText());
    parameter_b = new BigInteger(jTextFieldParameter_b.getText());
    faktor_n = new BigInteger(jTextField_Nachricht_M.getText());
    parameter_kA = new BigInteger(jTextFieldParameter_kA.getText());
    parameter_kB = new BigInteger(jTextFieldParameter_kB.getText());
    M = new BigInteger(jTextField_Nachricht_M.getText());
    
    punkt_x = new BigInteger(jTextFieldPunkt_x.getText());
    computePy();
    m_x = new BigInteger(jTextField_m_x.getText());
    compute_m_y();
    
    encryptSystem.setPrimeNumber(primZahl_p);
    encryptSystem.setParam_a(parameter_a);
    encryptSystem.setParam_b(parameter_b);
    BigInteger[] point = {punkt_x, punkt_y};
    encryptSystem.setP(point);
    try {
		encryptSystem.setKeyAlice(parameter_kA);
	} catch (Exception e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
    encryptSystem.setKeyBob(parameter_kB);
  }

  void computePy() {
  	  if (punkt_x.equals(primZahl_p)) {
  	  	  jTextPanePunkt_y1.setText("Unendlich ferner Punkt O");
          jTextPanePunkt_y2.setText("");
          punkt_y = BigInteger.ZERO;
          return;
  	  }
  	  
      BigInteger ySquare = punkt_x.pow(3).mod(primZahl_p);
      ySquare = ySquare.add(parameter_a.multiply(punkt_x)).mod(primZahl_p);
      ySquare = ySquare.add(parameter_b).mod(primZahl_p);

      punkt_y1 = ySquare.myModSqrt(primZahl_p);
      
      if (punkt_y1.equals(BigInteger.ONE.negate())) {
    	  jTextPanePunkt_y1.setText("Keine Lösung!");
          jTextPanePunkt_y2.setText("");
          punkt_y = punkt_y1;
          return;
      }      
      
      punkt_y2 = punkt_y1.negate().mod(primZahl_p);
      if (punkt_y1.pow(2).mod(primZahl_p).equals(ySquare)) {
          if (punkt_y1.compareTo(punkt_y2) > 0) {
              BigInteger swap = punkt_y1;
              punkt_y1 = punkt_y2;
              punkt_y2 = swap;
          }

          jTextPanePunkt_y1.setText(punkt_y1.toString());
          jTextPanePunkt_y2.setText(punkt_y2.toString());
          if (jRadioButtonPunkt_y1.isSelected()) {
              punkt_y = punkt_y1;
          }
          else {
              punkt_y = punkt_y2;
          }
      }
      else {
          jTextPanePunkt_y1.setText("Keine Lösung!");
          jTextPanePunkt_y2.setText("");
          punkt_y = BigInteger.ONE.negate();
      }
  }
  
  
  void compute_m_y() {
  	  if (m_x.equals(primZahl_p)) {
  	  	  jTextPane_m_y1.setText("Unendlich ferner Punkt O");
          jTextPane_m_y2.setText("");
          m_y = BigInteger.ZERO;
          return;
  	  }
  	  
      BigInteger ySquare = m_x.pow(3).mod(primZahl_p);
      ySquare = ySquare.add(parameter_a.multiply(m_x)).mod(primZahl_p);
      ySquare = ySquare.add(parameter_b).mod(primZahl_p);

      m_y1 = ySquare.myModSqrt(primZahl_p);
      
      if (m_y1.equals(BigInteger.ONE.negate())) {
    	  jTextPane_m_y1.setText("Keine Lösung!");
          jTextPane_m_y2.setText("");
          m_y = m_y1;
          return;
      }
      
      m_y2 = m_y1.negate().mod(primZahl_p);
      if (m_y1.pow(2).mod(primZahl_p).equals(ySquare)) {
          if (m_y1.compareTo(m_y2) > 0) {
              BigInteger swap = m_y1;
              m_y1 = m_y2;
              m_y2 = swap;
          }

          jTextPane_m_y1.setText(m_y1.toString());
          jTextPane_m_y2.setText(m_y2.toString());
          if (jRadioButton_m_y1.isSelected()) {
             m_y = m_y1;
          }
          else {
              m_y = m_y2;
          }
      }
      else {
          jTextPane_m_y1.setText("Keine Lösung!");
          jTextPane_m_y2.setText("");
          m_y = BigInteger.ONE.negate();
      }
  }

    public void jRadioButtonPunkt_y2_actionPerformed(ActionEvent e) {
        jRadioButtonPunkt_y1.setSelected(false);
        jRadioButtonPunkt_y2.setSelected(true);
        updateFields();
    }

    public void jRadioButtonPunkt_y1_actionPerformed(ActionEvent e) {
        jRadioButtonPunkt_y1.setSelected(true);
        jRadioButtonPunkt_y2.setSelected(false);
        updateFields();
    }
    
    
    
    public void jRadioButton_m_y1_actionPerformed(ActionEvent e) {
        jRadioButton_m_y1.setSelected(true);
        jRadioButton_m_y2.setSelected(false);
        updateFields();
    }
    
    
    public void jRadioButton_m_y2_actionPerformed(ActionEvent e) {
        jRadioButton_m_y1.setSelected(false);
        jRadioButton_m_y2.setSelected(true);
        updateFields();
    }
    
}

class MyFrameSerie13_jRadioButtonPunkt_y1_actionAdapter implements ActionListener {
    private FrameSerie13 adaptee;
    MyFrameSerie13_jRadioButtonPunkt_y1_actionAdapter(FrameSerie13 adaptee) {
        this.adaptee = adaptee;
    }

    public void actionPerformed(ActionEvent e) {
        adaptee.jRadioButtonPunkt_y1_actionPerformed(e);
    }
}



class MyFrameSerie13_jRadioButtonPunkt_y2_actionAdapter implements ActionListener {
    private FrameSerie13 adaptee;
    MyFrameSerie13_jRadioButtonPunkt_y2_actionAdapter(FrameSerie13 adaptee) {
        this.adaptee = adaptee;
    }

    public void actionPerformed(ActionEvent e) {
        adaptee.jRadioButtonPunkt_y2_actionPerformed(e);
    }
}


class MyFrameSerie13_jMenuDateiSchliessen_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie13 adaptee;

  MyFrameSerie13_jMenuDateiSchliessen_actionAdapter(FrameSerie13 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuDateiSchliessen_actionPerformed(e);
  }
}

class MyFrameSerie13_jButtonStartA_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie13 adaptee;

  MyFrameSerie13_jButtonStartA_actionAdapter(FrameSerie13 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStartA_actionPerformed(e);
  }
}

class MyFrameSerie13_jTextFieldPrimZahl_p_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie13 adaptee;

  MyFrameSerie13_jTextFieldPrimZahl_p_actionAdapter(FrameSerie13 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldPrimZahl_p_actionPerformed(e);
  }
}

class MyFrameSerie13_jTextFieldParameter_a_actionAdapter implements java.awt.event.ActionListener {
  FrameSerie13 adaptee;

  MyFrameSerie13_jTextFieldParameter_a_actionAdapter(FrameSerie13 adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldParameter_a_actionPerformed(e);
  }
}


class MyFrameSerie13_jTextFieldParameter_b_actionAdapter implements java.awt.event.ActionListener {
  FrameSerie13 adaptee;

  MyFrameSerie13_jTextFieldParameter_b_actionAdapter(FrameSerie13 adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldParameter_b_actionPerformed(e);
  }
}


class MyFrameSerie13_jTextFieldParameter_kA_actionAdapter implements java.awt.event.ActionListener {
	  FrameSerie13 adaptee;

	  MyFrameSerie13_jTextFieldParameter_kA_actionAdapter(FrameSerie13 adaptee) {
	    this.adaptee = adaptee;
	  }
	  public void actionPerformed(ActionEvent e) {
	    adaptee.jTextFieldParameter_kA_actionPerformed(e);
	  }
	}


class MyFrameSerie13_jTextFieldParameter_kB_actionAdapter implements java.awt.event.ActionListener {
	  FrameSerie13 adaptee;

	  MyFrameSerie13_jTextFieldParameter_kB_actionAdapter(FrameSerie13 adaptee) {
	    this.adaptee = adaptee;
	  }
	  public void actionPerformed(ActionEvent e) {
	    adaptee.jTextFieldParameter_kB_actionPerformed(e);
	  }
	}

class MyFrameSerie13_jTextFieldFaktor_n_actionAdapter implements java.awt.event.ActionListener {
  FrameSerie13 adaptee;

  MyFrameSerie13_jTextFieldFaktor_n_actionAdapter(FrameSerie13 adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldFaktor_n_actionPerformed(e);
  }
}

class MyFrameSerie13_jTextFieldPunkt_x_actionAdapter implements java.awt.event.ActionListener {
  FrameSerie13 adaptee;

  MyFrameSerie13_jTextFieldPunkt_x_actionAdapter(FrameSerie13 adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldPunkt_x_actionPerformed(e);
  }
}





class MyFrameSerie13_jRadioButton_m_y1_actionAdapter implements ActionListener {
    private FrameSerie13 adaptee;
    MyFrameSerie13_jRadioButton_m_y1_actionAdapter(FrameSerie13 adaptee) {
        this.adaptee = adaptee;
    }

    public void actionPerformed(ActionEvent e) {
        adaptee.jRadioButton_m_y1_actionPerformed(e);
    }
} 


class MyFrameSerie13_jRadioButton_m_y2_actionAdapter implements ActionListener {
    private FrameSerie13 adaptee;
    MyFrameSerie13_jRadioButton_m_y2_actionAdapter(FrameSerie13 adaptee) {
        this.adaptee = adaptee;
    }

    public void actionPerformed(ActionEvent e) {
        adaptee.jRadioButton_m_y2_actionPerformed(e);
    }
}


class MyFrameSerie13_jTextField_m_x_actionAdapter implements java.awt.event.ActionListener {
	  FrameSerie13 adaptee;

	  MyFrameSerie13_jTextField_m_x_actionAdapter(FrameSerie13 adaptee) {
	    this.adaptee = adaptee;
	  }

	  public void actionPerformed(ActionEvent e) {
	    adaptee.jTextField_m_x_actionPerformed(e);
	  }
}  

