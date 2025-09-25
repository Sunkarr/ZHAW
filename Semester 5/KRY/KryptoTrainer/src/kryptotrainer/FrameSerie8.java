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

public class FrameSerie8
    extends JFrame {
// Elemente des Frames
  JPanel contentPane;
  GridLayout gridLayoutContentPane = new GridLayout();
  JMenuBar jMenuBar1 = new JMenuBar();
  JPanel jPanel1 = new JPanel();
  JPanel jPanel2 = new JPanel();

// Elemente der MenuBar
  JMenu jMenuDatei = new JMenu();
  JMenuItem jMenuDateiSchliessen = new JMenuItem();

// Elemente jPanel1
  JButton jButtonStartA = new JButton();
  JLabel jLabelTitel = new JLabel();
  JLabel jLabelUntertitelA = new JLabel();
  JLabel jLabelEingabe = new JLabel();
  JLabel jLabelAusgabe = new JLabel();
  JTextField jTextFieldEingabe = new JTextField();
  JTextPane jTextPaneAusgabe = new JTextPane();

// Elemente jPanel2
  JLabel jLabelUntertitelB = new JLabel();
  JLabel jLabelTest1 = new JLabel();
  JLabel jLabelTest2 = new JLabel();
  JTextPane jTextPaneTest1 = new JTextPane();
  JTextPane jTextPaneTest2 = new JTextPane();

// Klassenvariablen
  private BigInteger eingabe = BigInteger.ZERO;
  private BigInteger ausgabe = BigInteger.ZERO;
  private BigInteger test1 = BigInteger.ZERO;
  private BigInteger test2 = BigInteger.ZERO;

  public FrameSerie8() {
    try {
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
// Allgemeine Initialisierungen
    this.setSize(new Dimension(650, 416));
    this.setTitle("KryptoTrainer Testumgebung zum Praktikum 10.1");

// Menu
    jMenuDatei.setText("Datei");
    jMenuDateiSchliessen.setText("Schliessen");
    jMenuDateiSchliessen.addActionListener(new
                                           FrameSerie8_jMenuDateiSchliessen_actionAdapter(this));

    jMenuDatei.add(jMenuDateiSchliessen);

    jMenuBar1.add(jMenuDatei);
    this.setJMenuBar(jMenuBar1);

// Panel 1
    jPanel1.setLayout(null);
    jPanel1.setBackground(Color.white);
    jButtonStartA.setText("Start");
    jButtonStartA.setBounds(new Rectangle(500, 108, 62, 25));
    jButtonStartA.addActionListener(new FrameSerie8_jButtonStartA_actionAdapter(this));
    jLabelTitel.setFont(new java.awt.Font("Times New Roman", 1, 19));
    jLabelTitel.setHorizontalAlignment(SwingConstants.LEFT);
    jLabelTitel.setHorizontalTextPosition(SwingConstants.LEADING);
    jLabelTitel.setText("Testumgebung zur Methode mySqrtFloor()");
    jLabelTitel.setBounds(new Rectangle(1, 1, 564, 23));
    jLabelUntertitelA.setText("a) Testberechnung");
    jLabelUntertitelA.setBounds(new Rectangle(9, 29, 255, 17));
    jLabelUntertitelA.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelEingabe.setText("Eingabewert n");
    jLabelEingabe.setBounds(new Rectangle(9, 56, 188, 15));
    jLabelAusgabe.setBounds(new Rectangle(9, 125, 196, 15));
    jLabelAusgabe.setText("Ausgabewert mySqrtFloor()");
    jTextFieldEingabe.setText(eingabe.toString());
    jTextFieldEingabe.setBounds(new Rectangle(9, 75, 553, 21));
    jTextFieldEingabe.addActionListener(new
                                      FrameSerie8_jTextFieldEingabe_actionAdapter(this));
    jTextFieldEingabe.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldEingabe.setSelectionEnd(11);
    jTextFieldEingabe.setNextFocusableComponent(null);
    jTextPaneAusgabe.setText(ausgabe.toString());
    jTextPaneAusgabe.setBounds(new Rectangle(9, 144, 553, 21));
    jTextPaneAusgabe.setEditable(false);
    jTextPaneAusgabe.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneAusgabe.setBackground(Color.lightGray);

    jPanel1.add(jLabelTitel, null);
    jPanel1.add(jLabelUntertitelA, null);
    jPanel1.add(jTextFieldEingabe, null);
    jPanel1.add(jLabelEingabe, null);
    jPanel1.add(jButtonStartA, null);
    jPanel1.add(jTextPaneAusgabe, null);
    jPanel1.add(jLabelAusgabe, null);

// Panel 2
    jPanel2.setLayout(null);
    jPanel2.setBackground(Color.white);
    jLabelUntertitelB.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelUntertitelB.setText("b) Test durch Zurückrechnen");
    jLabelUntertitelB.setBounds(new Rectangle(9, 3, 391, 17));
    jLabelTest1.setText("Ausgabe^2 - n (sollte kleiner gleich Null sein)");
    jLabelTest1.setBounds(new Rectangle(10, 32, 332, 15));
    jLabelTest2.setText("(Ausgabe+1)^2 - n (sollte grösser Null sein)");
    jLabelTest2.setBounds(new Rectangle(10, 104, 332, 15));
    jTextPaneTest1.setBackground(Color.lightGray);
    jTextPaneTest1.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneTest1.setEditable(false);
    jTextPaneTest1.setBounds(new Rectangle(10, 51, 553, 21));
    jTextPaneTest1.setText(test1.toString());
    jTextPaneTest2.setText(test2.toString());
    jTextPaneTest2.setBounds(new Rectangle(10, 123, 553, 21));
    jTextPaneTest2.setEditable(false);
    jTextPaneTest2.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneTest2.setBackground(Color.lightGray);

    jPanel2.add(jLabelUntertitelB, null);
    jPanel2.add(jTextPaneTest1, null);
    jPanel2.add(jLabelTest1, null);
    jPanel2.add(jTextPaneTest2, null);
    jPanel2.add(jLabelTest2, null);

// ContentPane
    contentPane = (JPanel)this.getContentPane();
    contentPane.setMinimumSize(new Dimension(800, 800));
    contentPane.setPreferredSize(new Dimension(800, 800));
    gridLayoutContentPane.setColumns(1);
    gridLayoutContentPane.setRows(2);
    contentPane.setLayout(gridLayoutContentPane);

    contentPane.add(jPanel1, null);
    contentPane.add(jPanel2, null);
  }

  void jButtonStartA_actionPerformed(ActionEvent e) {
    updateFields();

    ausgabe = eingabe.mySqrtFloor();
    test1 = (ausgabe.pow(2)).subtract(eingabe);
    test2 = ((ausgabe.add(BigInteger.ONE)).pow(2)).subtract(eingabe);

    jTextPaneAusgabe.setText(ausgabe.toString());
    jTextPaneTest1.setText(test1.toString());
    jTextPaneTest2.setText(test2.toString());
  }

  void jMenuDateiSchliessen_actionPerformed(ActionEvent e) {
    this.dispose();
  }

  void jTextFieldEingabe_actionPerformed(ActionEvent e) {
    updateFields();
    jTextFieldEingabe.selectAll();
  }

  void updateFields() {
    eingabe = new BigInteger(jTextFieldEingabe.getText());
  }
}

class FrameSerie8_jMenuDateiSchliessen_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie8 adaptee;

  FrameSerie8_jMenuDateiSchliessen_actionAdapter(FrameSerie8 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuDateiSchliessen_actionPerformed(e);
  }
}

class FrameSerie8_jButtonStartA_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie8 adaptee;

  FrameSerie8_jButtonStartA_actionAdapter(FrameSerie8 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStartA_actionPerformed(e);
  }
}

class FrameSerie8_jTextFieldEingabe_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie8 adaptee;

  FrameSerie8_jTextFieldEingabe_actionAdapter(FrameSerie8 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldEingabe_actionPerformed(e);
  }
}
