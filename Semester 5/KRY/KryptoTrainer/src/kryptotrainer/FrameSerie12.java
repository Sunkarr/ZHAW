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

public class FrameSerie12
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
  JLabel jLabelPrimzahl_p = new JLabel();
  JLabel jLabelParameter_a = new JLabel();
  JLabel jLabelResultat = new JLabel();
  JTextField jTextFieldPrimZahl_p = new JTextField();
  JTextField jTextFieldParameter_a = new JTextField();
  JTextPane jTextPaneResultat_x = new JTextPane();
  JTextField jTextFieldParameter_b = new JTextField();
  JLabel jLabelParameter_b = new JLabel();
  JTextField jTextFieldPunkt_x = new JTextField();
  JTextField jTextFieldFaktor_n = new JTextField();
    JLabel jLabelPunkt_y = new JLabel();
  JLabel jLabelPunkt_x = new JLabel();
  JLabel jLabelFaktor_n = new JLabel();
  JTextPane jTextPaneResultat_y = new JTextPane();
  JLabel jLabelResultat_y = new JLabel();
  JLabel jLabelResultat_x = new JLabel();
    JTextPane jTextPanePunkt_y2 = new JTextPane();
    JTextPane jTextPanePunkt_y1 = new JTextPane();
    JRadioButton jRadioButtonPunkt_y1 = new JRadioButton();
    JRadioButton jRadioButtonPunkt_y2 = new JRadioButton();

    public FrameSerie12() {
    try {
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
// Allgemeine Initialisierungen
    this.setSize(new Dimension(650, 650));
    this.setTitle("KryptoTrainer Testumgebung zum Praktikum 14.1");
    gridLayoutContentPane.setRows(1);

// Menu
    jMenuDatei.setText("Datei");
    jMenuDateiSchliessen.setText("Schliessen");
    jMenuDateiSchliessen.addActionListener(new
                                           FrameSerie12_jMenuDateiSchliessen_actionAdapter(this));
        jTextPanePunkt_y2.setBackground(Color.lightGray);
        jTextPanePunkt_y2.setBorder(BorderFactory.createEtchedBorder());
        jTextPanePunkt_y2.setEditable(false);
        jTextPanePunkt_y2.setText("");
        jTextPanePunkt_y2.setBounds(new Rectangle(9, 285, 278, 21));
        jTextPanePunkt_y1.setBackground(Color.lightGray);
        jTextPanePunkt_y1.setBorder(BorderFactory.createEtchedBorder());
        jTextPanePunkt_y1.setEditable(false);
        jTextPanePunkt_y1.setText("");
        jTextPanePunkt_y1.setBounds(new Rectangle(9, 258, 278, 21));
        jTextFieldPunkt_x.setBounds(new Rectangle(9, 232, 278, 21));
        jRadioButtonPunkt_y1.setText("");
        jRadioButtonPunkt_y1.setBounds(new Rectangle(289, 255, 19, 27));
        jRadioButtonPunkt_y1.addActionListener(new
                                        FrameSerie12_jRadioButtonPunkt_y1_actionAdapter(this));
        jRadioButtonPunkt_y2.setText("");
        jRadioButtonPunkt_y2.setBounds(new Rectangle(289, 282, 19, 27));
        jRadioButtonPunkt_y2.addActionListener(new
                                        FrameSerie12_jRadioButtonPunkt_y2_actionAdapter(this));
        jRadioButtonPunkt_y1.setSelected(true);

        jMenuDatei.add(jMenuDateiSchliessen);

    jMenuBar1.add(jMenuDatei);
    this.setJMenuBar(jMenuBar1);

// Panel 1
    jPanel1.setLayout(null);
    jPanel1.setBackground(Color.white);
    jButtonStartA.setText("Start");
    jButtonStartA.setBounds(new Rectangle(332, 370, 62, 25));
    jButtonStartA.addActionListener(new FrameSerie12_jButtonStartA_actionAdapter(this));
    jLabelTitel.setFont(new java.awt.Font("Times New Roman", 1, 19));
    jLabelTitel.setHorizontalAlignment(SwingConstants.LEFT);
    jLabelTitel.setHorizontalTextPosition(SwingConstants.LEADING);
    jLabelTitel.setText("Testumgebung zur Multiplikation auf elliptischen Kurven");
    jLabelTitel.setBounds(new Rectangle(1, 1, 564, 23));
    jLabelUntertitelA.setText("a) Grundkörper und Parameter der elliptischen Kurve");
    jLabelUntertitelA.setBounds(new Rectangle(9, 29, 420, 17));
    jLabelUntertitelA.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelPrimzahl_p.setText("Primzahl p für GF(p)");
    jLabelPrimzahl_p.setBounds(new Rectangle(291, 54, 188, 15));
    jLabelParameter_a.setBounds(new Rectangle(291, 78, 188, 15));
    jLabelParameter_a.setText("Parameter a");
    jLabelUntertitelB.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelUntertitelB.setText("b) Multiplikation");
    jLabelUntertitelB.setBounds(new Rectangle(9, 184, 391, 17));
    jLabelResultat.setText("Ergebnis Q=n*P");
    jLabelResultat.setBounds(new Rectangle(9, 406, 278, 15));
    jTextFieldPrimZahl_p.setBounds(new Rectangle(9, 51, 278, 21));
    jTextFieldPrimZahl_p.setText(primZahl_p.toString());
    jTextFieldPrimZahl_p.addActionListener(new
                                      FrameSerie12_jTextFieldPrimZahl_p_actionAdapter(this));
    jTextFieldPrimZahl_p.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldPrimZahl_p.setSelectionEnd(11);
    jTextFieldPrimZahl_p.setNextFocusableComponent(null);
    jTextFieldParameter_a.setText(parameter_a.toString());
    jTextFieldParameter_a.setNextFocusableComponent(null);
    jTextFieldParameter_a.setSelectionEnd(11);
    jTextFieldParameter_a.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldParameter_a.addActionListener(new
                                      FrameSerie12_jTextFieldParameter_a_actionAdapter(this));
    jTextFieldParameter_a.setBounds(new Rectangle(9, 75, 278, 21));
    jTextPaneResultat_x.setBackground(Color.lightGray);
    jTextPaneResultat_x.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneResultat_x.setEditable(false);
    jTextPaneResultat_x.setBounds(new Rectangle(9, 422, 278, 21));
    jTextFieldParameter_b.setBounds(new Rectangle(9, 98, 278, 21));
    jTextFieldParameter_b.addActionListener(new FrameSerie12_jTextFieldParameter_b_actionAdapter(this));
    jTextFieldParameter_b.addActionListener(new
                                      FrameSerie12_jTextFieldParameter_b_actionAdapter(this));
    jTextFieldParameter_b.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldParameter_b.setSelectionEnd(11);
    jTextFieldParameter_b.setNextFocusableComponent(null);
    jTextFieldParameter_b.setText(parameter_b.toString());
    jLabelParameter_b.setText("Parameter b");
    jLabelParameter_b.setBounds(new Rectangle(291, 101, 188, 15));
        jTextFieldPunkt_x.addActionListener(new
                                      FrameSerie12_jTextFieldPunkt_x_actionAdapter(this));
    jTextFieldPunkt_x.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldPunkt_x.setSelectionEnd(11);
    jTextFieldPunkt_x.setNextFocusableComponent(null);
    jTextFieldPunkt_x.setText(punkt_x.toString());
    jTextFieldFaktor_n.setNextFocusableComponent(null);
    jTextFieldFaktor_n.setSelectionEnd(11);
    jTextFieldFaktor_n.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldFaktor_n.addActionListener(new
                                      FrameSerie12_jTextFieldFaktor_n_actionAdapter(this));
    jTextFieldFaktor_n.setText(faktor_n.toString());
    jTextFieldFaktor_n.setBounds(new Rectangle(9, 206, 278, 21));
        jLabelPunkt_y.setBounds(new Rectangle(318, 273, 209, 15));
    jLabelPunkt_y.setText("Wahl der y-Komponente von P");
    jLabelPunkt_x.setText("x-Komponente von P");
    jLabelPunkt_x.setBounds(new Rectangle(318, 235, 209, 15));
    jLabelFaktor_n.setBounds(new Rectangle(318, 209, 209, 15));
    jLabelFaktor_n.setText("Faktor n");
    jTextPaneResultat_y.setBounds(new Rectangle(9, 446, 278, 21));
    jTextPaneResultat_y.setEditable(false);
    jTextPaneResultat_y.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneResultat_y.setBackground(Color.lightGray);
    jLabelResultat_y.setBounds(new Rectangle(291, 449, 188, 15));
    jLabelResultat_y.setText("y-Komponente von Q");
    jLabelResultat_x.setText("x-Komponente von Q");
    jLabelResultat_x.setBounds(new Rectangle(291, 425, 188, 15));

    jPanel1.add(jLabelTitel, null);
    jPanel1.add(jLabelUntertitelA, null);
    jPanel1.add(jTextFieldPrimZahl_p, null);
    jPanel1.add(jLabelPrimzahl_p, null);
    jPanel1.add(jTextFieldParameter_a, null);
    jPanel1.add(jTextFieldParameter_b, null);
    jPanel1.add(jLabelParameter_a, null);
    jPanel1.add(jLabelParameter_b, null);
    jPanel1.add(jLabelUntertitelB, null);
    jPanel1.add(jTextFieldFaktor_n, null);
    jPanel1.add(jTextFieldPunkt_x, null);
        jPanel1.add(jTextPaneResultat_x, null);
        jPanel1.add(jButtonStartA, null);
        jPanel1.add(jLabelResultat, null);
        jPanel1.add(jTextPaneResultat_y, null);
        jPanel1.add(jLabelResultat_x, null);
        jPanel1.add(jLabelResultat_y, null);
        jPanel1.add(jTextPanePunkt_y1);
        jPanel1.add(jTextPanePunkt_y2);
        jPanel1.add(jRadioButtonPunkt_y1);
        jPanel1.add(jRadioButtonPunkt_y2);
        jPanel1.add(jLabelPunkt_x, null);
        jPanel1.add(jLabelFaktor_n, null);
        jPanel1.add(jLabelPunkt_y, null);

        // ContentPane
    contentPane = (JPanel)this.getContentPane();
    contentPane.setMinimumSize(new Dimension(600, 800));
    contentPane.setPreferredSize(new Dimension(600, 800));
    gridLayoutContentPane.setColumns(1);
    contentPane.setLayout(gridLayoutContentPane);

    contentPane.add(jPanel1, null);
    }

  void jButtonStartA_actionPerformed(ActionEvent e) {
    BigInteger[] res;

    updateFields();

    // Testberechnungen
    if (! punkt_y.equals(BigInteger.ONE.negate())) {
        try {
          res = punkt_x.elliptMultiply(punkt_y, faktor_n, primZahl_p, parameter_a, parameter_b);
          
          // Unendlich ferner Punkt: O=(p,*)
          if (res[0].equals(primZahl_p)) {
            jTextPaneResultat_x.setText("Unendlich ferner Punkt O");
            jTextPaneResultat_y.setText("");
          }
          else {
            jTextPaneResultat_x.setText(res[0].toString());
            jTextPaneResultat_y.setText(res[1].toString());
          }
        }
        catch (Exception ex) {
          jTextPaneResultat_x.setText(ex.getMessage());
          jTextPaneResultat_y.setText("");
        }
    }
    else {
        jTextPaneResultat_x.setText("");
        jTextPaneResultat_y.setText("");
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
    jTextFieldFaktor_n.selectAll();
  }

  void jTextFieldPunkt_x_actionPerformed(ActionEvent e) {
    updateFields();
    jTextFieldPunkt_x.selectAll();
  }

  void updateFields() {
    primZahl_p = new BigInteger(jTextFieldPrimZahl_p.getText());
    parameter_a = new BigInteger(jTextFieldParameter_a.getText());
    parameter_b = new BigInteger(jTextFieldParameter_b.getText());
    faktor_n = new BigInteger(jTextFieldFaktor_n.getText());
    punkt_x = new BigInteger(jTextFieldPunkt_x.getText());
    computePy();
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
}


class FrameSerie12_jRadioButtonPunkt_y1_actionAdapter implements ActionListener {
    private FrameSerie12 adaptee;
    FrameSerie12_jRadioButtonPunkt_y1_actionAdapter(FrameSerie12 adaptee) {
        this.adaptee = adaptee;
    }

    public void actionPerformed(ActionEvent e) {
        adaptee.jRadioButtonPunkt_y1_actionPerformed(e);
    }
}


class FrameSerie12_jRadioButtonPunkt_y2_actionAdapter implements ActionListener {
    private FrameSerie12 adaptee;
    FrameSerie12_jRadioButtonPunkt_y2_actionAdapter(FrameSerie12 adaptee) {
        this.adaptee = adaptee;
    }

    public void actionPerformed(ActionEvent e) {
        adaptee.jRadioButtonPunkt_y2_actionPerformed(e);
    }
}


class FrameSerie12_jMenuDateiSchliessen_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie12 adaptee;

  FrameSerie12_jMenuDateiSchliessen_actionAdapter(FrameSerie12 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuDateiSchliessen_actionPerformed(e);
  }
}

class FrameSerie12_jButtonStartA_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie12 adaptee;

  FrameSerie12_jButtonStartA_actionAdapter(FrameSerie12 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStartA_actionPerformed(e);
  }
}

class FrameSerie12_jTextFieldPrimZahl_p_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie12 adaptee;

  FrameSerie12_jTextFieldPrimZahl_p_actionAdapter(FrameSerie12 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldPrimZahl_p_actionPerformed(e);
  }
}

class FrameSerie12_jTextFieldParameter_a_actionAdapter implements java.awt.event.ActionListener {
  FrameSerie12 adaptee;

  FrameSerie12_jTextFieldParameter_a_actionAdapter(FrameSerie12 adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldParameter_a_actionPerformed(e);
  }
}


class FrameSerie12_jTextFieldParameter_b_actionAdapter implements java.awt.event.ActionListener {
  FrameSerie12 adaptee;

  FrameSerie12_jTextFieldParameter_b_actionAdapter(FrameSerie12 adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldParameter_b_actionPerformed(e);
  }
}

class FrameSerie12_jTextFieldFaktor_n_actionAdapter implements java.awt.event.ActionListener {
  FrameSerie12 adaptee;

  FrameSerie12_jTextFieldFaktor_n_actionAdapter(FrameSerie12 adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldFaktor_n_actionPerformed(e);
  }
}

class FrameSerie12_jTextFieldPunkt_x_actionAdapter implements java.awt.event.ActionListener {
  FrameSerie12 adaptee;

  FrameSerie12_jTextFieldPunkt_x_actionAdapter(FrameSerie12 adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldPunkt_x_actionPerformed(e);
  }
}
