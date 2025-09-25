package kryptotrainer;

import java.lang.*;

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

public class FrameSerie7
    extends JFrame {
// Elemente des Frames
  JPanel contentPane;
  GridLayout gridLayoutContentPane = new GridLayout();
  JMenuBar jMenuBar1 = new JMenuBar();
  JPanel jPanel1 = new JPanel();
  JPanel jPanel2 = new JPanel();
  JPanel jPanel3 = new JPanel();

// Elemente der MenuBar
  JMenu jMenuDatei = new JMenu();
  JMenuItem jMenuDateiSchliessen = new JMenuItem();

// Elemente jPanel1
  JButton jButtonStartA = new JButton();
  JLabel jLabelTitel = new JLabel();
  JLabel jLabelUntertitelA = new JLabel();
  JLabel jLabelSchluesselLaenge = new JLabel();
  JLabel jLabelOeffSchl_p = new JLabel();
  JLabel jLabelOeffSchl_g = new JLabel();
  JLabel jLabelOeffSchl_A = new JLabel();
  JLabel jLabelPrivSchl_a = new JLabel();
  JTextField jTextFieldSchluesselLaenge = new JTextField();
  JTextArea jTextAreaOeffSchl_p = new JTextArea();
  JTextArea jTextAreaOeffSchl_g = new JTextArea();
  JTextArea jTextAreaOeffSchl_A = new JTextArea();
  JTextArea jTextAreaPrivSchl_a = new JTextArea();

// Elemente jPanel2
  JButton jButtonStartB = new JButton();
  JLabel jLabelUntertitelB = new JLabel();
  JLabel jLabelKlarText = new JLabel();
  JLabel jLabelVerschl_B = new JLabel();
  JLabel jLabelVerschl_c = new JLabel();
  JTextField jTextFieldKlarText = new JTextField();
  JTextArea jTextAreaVerschl_B = new JTextArea();
  JTextArea jTextAreaVerschl_c = new JTextArea();

// Elemente jPanel3
  JButton jButtonStartC = new JButton();
  JLabel jLabelUntertitelC = new JLabel();
  JLabel jLabelEntschl = new JLabel();
  JTextArea jTextAreaEntschl = new JTextArea();

// Klassenvariablen
  int anzStellen;
  BigInteger klarText;
  BigInteger[] oeffSchl;
  BigInteger privSchl;
  BigInteger[] verschl;
  BigInteger entschl;
  ElGamal kryptoSystem = new ElGamal();

  public FrameSerie7() {
    try {
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
// Allgemeine Initialisierungen
    this.setSize(new Dimension(600, 800));
    this.setTitle("KryptoTrainer Testumgebung zum Praktikum 8.2");

// Menu
    jMenuDatei.setText("Datei");
    jMenuDateiSchliessen.setText("Schliessen");
    jMenuDateiSchliessen.addActionListener(new
                                           FrameSerie7_jMenuDateiSchliessen_actionAdapter(this));
    jMenuDatei.add(jMenuDateiSchliessen);

    jMenuBar1.add(jMenuDatei);
    this.setJMenuBar(jMenuBar1);

// Schriftart und Grösse für JTextArea Felder
    Font font = new Font(Font.MONOSPACED, Font.PLAIN, 13);
    
// Panel 1
    jPanel1.setLayout(null);
    jPanel1.setBackground(Color.white);
    jButtonStartA.setText("Start");
    jButtonStartA.setBounds(new Rectangle(496, 46, 62, 25));
    jButtonStartA.addActionListener(new FrameSerie7_jButtonStartA_actionAdapter(this));
    jLabelTitel.setFont(new java.awt.Font("Times New Roman", 1, 19));
    jLabelTitel.setHorizontalAlignment(SwingConstants.LEFT);
    jLabelTitel.setHorizontalTextPosition(SwingConstants.LEADING);
    jLabelTitel.setText("Testumgebung zur El Gamal Verschlüsselung");
    jLabelTitel.setBounds(new Rectangle(1, 1, 564, 23));
    jLabelUntertitelA.setText("a) Schlüsselerzeugung für Alice");
    jLabelUntertitelA.setBounds(new Rectangle(9, 29, 255, 17));
    jLabelUntertitelA.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelSchluesselLaenge.setText("Schlüssellänge");
    jLabelSchluesselLaenge.setBounds(new Rectangle(90, 51, 188, 15));
    jLabelOeffSchl_p.setText("Öffentlicher Schlüssel p");
    jLabelOeffSchl_p.setBounds(new Rectangle(383, 87, 196, 15));
    jLabelOeffSchl_g.setBounds(new Rectangle(383, 126, 196, 15));
    jLabelOeffSchl_g.setText("Öffentlicher Schlüssel g");
    jLabelOeffSchl_A.setBounds(new Rectangle(383, 164, 196, 15));
    jLabelOeffSchl_A.setText("Öffentlicher Schlüssel A");
    jLabelPrivSchl_a.setBounds(new Rectangle(383, 213, 196, 15));
    jLabelPrivSchl_a.setText("Privater Schlüssel a");
    jTextFieldSchluesselLaenge.setText("0");
    jTextFieldSchluesselLaenge.setBounds(new Rectangle(9, 48, 79, 21));
    jTextFieldSchluesselLaenge.addActionListener(new
                                      FrameSerie7_jTextFieldSchluesselLaenge_actionAdapter(this));
    jTextFieldSchluesselLaenge.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldSchluesselLaenge.setSelectionEnd(11);

    jTextAreaOeffSchl_p.setText("");
    jTextAreaOeffSchl_p.setBounds(new Rectangle(8, 74, 373, 40));
    jTextAreaOeffSchl_p.setEditable(false);
    jTextAreaOeffSchl_p.setBorder(BorderFactory.createEtchedBorder());
    jTextAreaOeffSchl_p.setBackground(Color.lightGray);
    jTextAreaOeffSchl_p.setFont(font);
    jTextAreaOeffSchl_p.setLineWrap(true);

    jTextAreaOeffSchl_g.setBackground(Color.lightGray);
    jTextAreaOeffSchl_g.setBorder(BorderFactory.createEtchedBorder());
    jTextAreaOeffSchl_g.setEditable(false);
    jTextAreaOeffSchl_g.setBounds(new Rectangle(8, 113, 373, 40));
    jTextAreaOeffSchl_g.setText("");
    jTextAreaOeffSchl_g.setFont(font);
    jTextAreaOeffSchl_g.setLineWrap(true);

    jTextAreaOeffSchl_A.setBackground(Color.lightGray);
    jTextAreaOeffSchl_A.setBorder(BorderFactory.createEtchedBorder());
    jTextAreaOeffSchl_A.setEditable(false);
    jTextAreaOeffSchl_A.setBounds(new Rectangle(8, 151, 373, 40));
    jTextAreaOeffSchl_A.setText("");
    jTextAreaOeffSchl_A.setFont(font);
    jTextAreaOeffSchl_A.setLineWrap(true);

    jTextAreaPrivSchl_a.setText("");
    jTextAreaPrivSchl_a.setBounds(new Rectangle(8, 200, 373, 40));
    jTextAreaPrivSchl_a.setEditable(false);
    jTextAreaPrivSchl_a.setBorder(BorderFactory.createEtchedBorder());
    jTextAreaPrivSchl_a.setBackground(Color.lightGray);
    jTextAreaPrivSchl_a.setFont(font);
    jTextAreaPrivSchl_a.setLineWrap(true);

    jPanel1.add(jButtonStartA, null);
    jPanel1.add(jLabelTitel, null);
    jPanel1.add(jLabelUntertitelA, null);
    jPanel1.add(jLabelSchluesselLaenge, null);
    jPanel1.add(jLabelOeffSchl_p, null);
    jPanel1.add(jLabelOeffSchl_g, null);
    jPanel1.add(jLabelOeffSchl_A, null);
    jPanel1.add(jLabelPrivSchl_a, null);
    jPanel1.add(jTextFieldSchluesselLaenge, null);
    jPanel1.add(jTextAreaOeffSchl_p, null);
    jPanel1.add(jTextAreaOeffSchl_g, null);
    jPanel1.add(jTextAreaOeffSchl_A, null);
    jPanel1.add(jTextAreaPrivSchl_a, null);

// Panel 2
    jPanel2.setLayout(null);
    jPanel2.setBackground(Color.white);
    jButtonStartB.setBounds(new Rectangle(496, 85, 62, 25));
    jButtonStartB.setText("Start");
    jButtonStartB.addActionListener(new FrameSerie7_jButtonStartB_actionAdapter(this));
    jLabelUntertitelB.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelUntertitelB.setText("b) Verschlüsselung einer Nachricht Bob -> Alice");
    jLabelUntertitelB.setBounds(new Rectangle(9, 3, 391, 17));
    jLabelKlarText.setBounds(new Rectangle(384, 38, 196, 15));
    jLabelKlarText.setText("Klartext");
    jLabelVerschl_B.setBounds(new Rectangle(384, 153, 196, 15));
    jLabelVerschl_B.setText("Verschlüsselte Nachricht B");
    jLabelVerschl_c.setBounds(new Rectangle(384, 191, 196, 15));
    jLabelVerschl_c.setText("Verschlüsselte Nachricht c");
    jTextFieldKlarText.setSelectionEnd(11);
    jTextFieldKlarText.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldKlarText.setBounds(new Rectangle(9, 25, 373, 40));
    jTextFieldKlarText.addActionListener(new FrameSerie7_jTextFieldKlarText_actionAdapter(this));
    jTextFieldKlarText.setText("0");

    jTextAreaVerschl_c.setText("");
    jTextAreaVerschl_c.setBounds(new Rectangle(9, 178, 373, 40));
    jTextAreaVerschl_c.setEditable(false);
    jTextAreaVerschl_c.setBorder(BorderFactory.createEtchedBorder());
    jTextAreaVerschl_c.setBackground(Color.lightGray);
    jTextAreaVerschl_c.setFont(font);
    jTextAreaVerschl_c.setLineWrap(true);

    jTextAreaVerschl_B.setText("");
    jTextAreaVerschl_B.setBounds(new Rectangle(9, 140, 373, 40));
    jTextAreaVerschl_B.setEditable(false);
    jTextAreaVerschl_B.setBorder(BorderFactory.createEtchedBorder());
    jTextAreaVerschl_B.setBackground(Color.lightGray);
    jTextAreaVerschl_B.setFont(font);
    jTextAreaVerschl_B.setLineWrap(true);

    jPanel2.add(jButtonStartB, null);
    jPanel2.add(jLabelUntertitelB, null);
    jPanel2.add(jLabelKlarText, null);
    jPanel2.add(jLabelVerschl_B, null);
    jPanel2.add(jLabelVerschl_c, null);
    jPanel2.add(jTextFieldKlarText, null);
    jPanel2.add(jTextAreaVerschl_B, null);
    jPanel2.add(jTextAreaVerschl_c, null);

// Panel 3
    jPanel3.setLayout(null);
    jPanel3.setBackground(Color.white);
    jPanel3.setOpaque(true);
    jButtonStartC.addActionListener(new FrameSerie7_jButtonStartC_actionAdapter(this));
    jButtonStartC.setText("Start");
    jButtonStartC.addActionListener(new FrameSerie7_jButtonStartC_actionAdapter(this));
    jButtonStartC.setBounds(new Rectangle(492, 33, 62, 25));
    jLabelUntertitelC.setText("c) Entschlüsselung der Nachricht Bob -> Alice");
    jLabelUntertitelC.setBounds(new Rectangle(8, 0, 351, 17));
    jLabelUntertitelC.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelEntschl.setBounds(new Rectangle(383, 127, 196, 15));
    jLabelEntschl.setText("Entschlüsselte Nachricht");
    jTextAreaEntschl.setBackground(Color.lightGray);
    jTextAreaEntschl.setBorder(BorderFactory.createEtchedBorder());
    jTextAreaEntschl.setEditable(false);
    jTextAreaEntschl.setBounds(new Rectangle(8, 114, 373, 40));
    jTextAreaEntschl.setText("");
    jTextAreaEntschl.setFont(font);
    jTextAreaEntschl.setLineWrap(true);

    jPanel3.add(jButtonStartC, null);
    jPanel3.add(jLabelUntertitelC, null);
    jPanel3.add(jLabelEntschl, null);
    jPanel3.add(jTextAreaEntschl, null);

// ContentPane
    contentPane = (JPanel)this.getContentPane();
    contentPane.setMinimumSize(new Dimension(600, 800));
    contentPane.setPreferredSize(new Dimension(600, 800));
    gridLayoutContentPane.setColumns(1);
    gridLayoutContentPane.setRows(3);
    contentPane.setLayout(gridLayoutContentPane);

    contentPane.add(jPanel1, null);
    contentPane.add(jPanel2, null);
    contentPane.add(jPanel3, null);
  }

  void jButtonStartA_actionPerformed(ActionEvent e) {
    updateFields();

    kryptoSystem.setBitLength(anzStellen);
    kryptoSystem.generateKeyPair();

    oeffSchl = kryptoSystem.getPublicKey();
    privSchl = kryptoSystem.getPrivateKey();
    jTextAreaOeffSchl_p.setText(oeffSchl[0].toString());
    jTextAreaOeffSchl_g.setText(oeffSchl[1].toString());
    jTextAreaOeffSchl_A.setText(oeffSchl[2].toString());
    jTextAreaPrivSchl_a.setText(privSchl.toString());
  }

  void jButtonStartB_actionPerformed(ActionEvent e) {
    updateFields();

    kryptoSystem.setPlainText(klarText);
    kryptoSystem.createCipheredText();

    verschl = kryptoSystem.getCipheredText();
    jTextAreaVerschl_B.setText(verschl[0].toString());
    jTextAreaVerschl_c.setText(verschl[1].toString());
  }

  void jButtonStartC_actionPerformed(ActionEvent e) {
    updateFields();

    kryptoSystem.createDecipheredText();

    entschl = kryptoSystem.getDecipheredText();
    jTextAreaEntschl.setText(entschl.toString());
  }

  void jMenuDateiSchliessen_actionPerformed(ActionEvent e) {
    this.dispose();
  }

  void jTextFieldKlarText_actionPerformed(ActionEvent e) {
    updateFields();
    jTextFieldKlarText.selectAll();
  }

  void jTextFieldSchluesselLaenge_actionPerformed(ActionEvent e) {
    updateFields();
    jTextFieldSchluesselLaenge.selectAll();
  }

  void updateFields() {
    anzStellen = Integer.valueOf(jTextFieldSchluesselLaenge.getText()).intValue();
    klarText = new BigInteger(jTextFieldKlarText.getText());
  }
}

class FrameSerie7_jMenuDateiSchliessen_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie7 adaptee;

  FrameSerie7_jMenuDateiSchliessen_actionAdapter(FrameSerie7 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuDateiSchliessen_actionPerformed(e);
  }
}

class FrameSerie7_jButtonStartB_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie7 adaptee;

  FrameSerie7_jButtonStartB_actionAdapter(FrameSerie7 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStartB_actionPerformed(e);
  }
}

class FrameSerie7_jButtonStartA_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie7 adaptee;

  FrameSerie7_jButtonStartA_actionAdapter(FrameSerie7 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStartA_actionPerformed(e);
  }
}

class FrameSerie7_jTextFieldSchluesselLaenge_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie7 adaptee;

  FrameSerie7_jTextFieldSchluesselLaenge_actionAdapter(FrameSerie7 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldSchluesselLaenge_actionPerformed(e);
  }
}

class FrameSerie7_jTextFieldKlarText_actionAdapter implements java.awt.event.ActionListener {
  FrameSerie7 adaptee;

  FrameSerie7_jTextFieldKlarText_actionAdapter(FrameSerie7 adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldKlarText_actionPerformed(e);
  }
}

class FrameSerie7_jButtonStartC_actionAdapter implements java.awt.event.ActionListener {
  FrameSerie7 adaptee;

  FrameSerie7_jButtonStartC_actionAdapter(FrameSerie7 adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStartC_actionPerformed(e);
  }
}
