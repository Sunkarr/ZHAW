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

public class FrameSerie11
    extends JFrame {

// Klassenvariablen
  private BigInteger primZahl_p = new BigInteger("3");
  private BigInteger parameter_a = new BigInteger("1");
  private BigInteger parameter_b = new BigInteger("1");
  private BigInteger P_x = new BigInteger("0");
  private BigInteger P_y = new BigInteger("0");
  private BigInteger P_y1 = P_y;
  private BigInteger P_y2 = P_y;

  private BigInteger Q_x = new BigInteger("0");
  private BigInteger Q_y = new BigInteger("0");
  private BigInteger Q_y1 = Q_y;
  private BigInteger Q_y2 = Q_y;

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
    JTextPane jTextPaneResultat_y = new JTextPane();
  JLabel jLabelResultat_y = new JLabel();
  JLabel jLabelResultat_x = new JLabel();
    JTextPane jTextPanePunkt_y2 = new JTextPane();
    JTextPane jTextPanePunkt_y1 = new JTextPane();
    JRadioButton jRadioButtonPunkt_y1 = new JRadioButton();
    JRadioButton jRadioButtonPunkt_y2 = new JRadioButton();
    JTextField jTextFieldQunkt_x = new JTextField();
    JTextPane jTextPaneQunkt_y1 = new JTextPane();
    JTextPane jTextPaneQunkt_y2 = new JTextPane();
    JRadioButton jRadioButtonQunkt_y1 = new JRadioButton();
    JRadioButton jRadioButtonQunkt_y2 = new JRadioButton();
    JLabel jLabelQunkt_x = new JLabel();
    JLabel jLabelQunkt_y = new JLabel();

    public FrameSerie11() {
    try {
      jbInit();
    }
    catch (Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
// Allgemeine Initialisierungen
    this.setSize(new Dimension(650, 700));
    this.setTitle("KryptoTrainer Testumgebung zum Praktikum 12.2");
    gridLayoutContentPane.setRows(1);

// Menu
    jMenuDatei.setText("Datei");
    jMenuDateiSchliessen.setText("Schliessen");
    jMenuDateiSchliessen.addActionListener(new
                                           FrameSerie11_jMenuDateiSchliessen_actionAdapter(this));
        jTextPanePunkt_y2.setBackground(Color.lightGray);
        jTextPanePunkt_y2.setBorder(BorderFactory.createEtchedBorder());
        jTextPanePunkt_y2.setEditable(false);
        jTextPanePunkt_y2.setText("");
        jTextPanePunkt_y2.setBounds(new Rectangle(9, 249, 278, 21));
        jTextPanePunkt_y1.setBackground(Color.lightGray);
        jTextPanePunkt_y1.setBorder(BorderFactory.createEtchedBorder());
        jTextPanePunkt_y1.setEditable(false);
        jTextPanePunkt_y1.setText("");
        jTextPanePunkt_y1.setBounds(new Rectangle(9, 227, 278, 21));
        jTextFieldPunkt_x.setBounds(new Rectangle(9, 205, 278, 21));
        jRadioButtonPunkt_y1.setText("");
        jRadioButtonPunkt_y1.setBounds(new Rectangle(287, 222, 19, 27));
        jRadioButtonPunkt_y1.addActionListener(new
                                        FrameSerie11_jRadioButtonPunkt_y1_actionAdapter(this));
        jRadioButtonPunkt_y2.setText("");
        jRadioButtonPunkt_y2.setBounds(new Rectangle(287, 247, 19, 27));
        jRadioButtonPunkt_y2.addActionListener(new
                                        FrameSerie11_jRadioButtonPunkt_y2_actionAdapter(this));
        jRadioButtonPunkt_y1.setSelected(true);
        jTextFieldQunkt_x.setText("0");
        jTextFieldQunkt_x.setHorizontalAlignment(SwingConstants.RIGHT);
        jTextFieldQunkt_x.setBounds(new Rectangle(9, 284, 278, 21));
        jTextFieldQunkt_x.addActionListener(new
                FrameSerie11_jTextFieldQunkt_x_actionAdapter(this));
        jTextPaneQunkt_y1.setBackground(Color.lightGray);
        jTextPaneQunkt_y1.setBorder(BorderFactory.createEtchedBorder());
        jTextPaneQunkt_y1.setEditable(false);
        jTextPaneQunkt_y1.setBounds(new Rectangle(9, 306, 278, 21));
        jTextPaneQunkt_y2.setBackground(Color.lightGray);
        jTextPaneQunkt_y2.setBorder(BorderFactory.createEtchedBorder());
        jTextPaneQunkt_y2.setEditable(false);
        jTextPaneQunkt_y2.setBounds(new Rectangle(9, 327, 278, 21));
        jRadioButtonQunkt_y1.setSelected(true);
        jRadioButtonQunkt_y1.setBounds(new Rectangle(287, 304, 19, 27));
        jRadioButtonQunkt_y1.addActionListener(new
                FrameSerie11_jRadioButtonQunkt_y1_actionAdapter(this));
        jRadioButtonQunkt_y2.setBounds(new Rectangle(287, 327, 19, 27));
        jRadioButtonQunkt_y2.addActionListener(new
                FrameSerie11_jRadioButtonQunkt_y2_actionAdapter(this));
        jLabelQunkt_x.setText("x-Komponente von Q");
        jLabelQunkt_x.setBounds(new Rectangle(317, 288, 209, 15));
        jLabelQunkt_y.setText("Wahl der y-Komponente von Q");
        jLabelQunkt_y.setBounds(new Rectangle(317, 321, 209, 15));
        jMenuDatei.add(jMenuDateiSchliessen);

    jMenuBar1.add(jMenuDatei);
    this.setJMenuBar(jMenuBar1);

// Panel 1
    jPanel1.setLayout(null);
    jPanel1.setBackground(Color.white);
    jButtonStartA.setText("Start");
    jButtonStartA.setBounds(new Rectangle(332, 370, 62, 25));
    jButtonStartA.addActionListener(new FrameSerie11_jButtonStartA_actionAdapter(this));
    jLabelTitel.setFont(new java.awt.Font("Times New Roman", 1, 19));
    jLabelTitel.setHorizontalAlignment(SwingConstants.LEFT);
    jLabelTitel.setHorizontalTextPosition(SwingConstants.LEADING);
    jLabelTitel.setText("Testumgebung zur Addition auf elliptischen Kurven");
    jLabelTitel.setBounds(new Rectangle(1, 1, 564, 23));
    jLabelUntertitelA.setText("a) Grundkörper und Parameter der elliptischen Kurve");
    jLabelUntertitelA.setBounds(new Rectangle(9, 29, 420, 17));
    jLabelUntertitelA.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelPrimzahl_p.setText("Primzahl p für GF(p)");
    jLabelPrimzahl_p.setBounds(new Rectangle(291, 54, 188, 15));
    jLabelParameter_a.setBounds(new Rectangle(291, 78, 188, 15));
    jLabelParameter_a.setText("Parameter a");
    jLabelUntertitelB.setFont(new java.awt.Font("Times New Roman", 1, 15));
    jLabelUntertitelB.setText("b) Addition");
    jLabelUntertitelB.setBounds(new Rectangle(9, 184, 391, 17));
    jLabelResultat.setText("Ergebnis R=P+Q");
    jLabelResultat.setBounds(new Rectangle(9, 406, 278, 15));
    jTextFieldPrimZahl_p.setBounds(new Rectangle(9, 51, 278, 21));
    jTextFieldPrimZahl_p.setText(primZahl_p.toString());
    jTextFieldPrimZahl_p.addActionListener(new
                                      FrameSerie11_jTextFieldPrimZahl_p_actionAdapter(this));
    jTextFieldPrimZahl_p.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldPrimZahl_p.setSelectionEnd(11);
    jTextFieldPrimZahl_p.setNextFocusableComponent(null);
    jTextFieldParameter_a.setText(parameter_a.toString());
    jTextFieldParameter_a.setNextFocusableComponent(null);
    jTextFieldParameter_a.setSelectionEnd(11);
    jTextFieldParameter_a.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldParameter_a.addActionListener(new
                                      FrameSerie11_jTextFieldParameter_a_actionAdapter(this));
    jTextFieldParameter_a.setBounds(new Rectangle(9, 75, 278, 21));
    jTextPaneResultat_x.setBackground(Color.lightGray);
    jTextPaneResultat_x.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneResultat_x.setEditable(false);
    jTextPaneResultat_x.setBounds(new Rectangle(9, 422, 278, 21));
    jTextFieldParameter_b.setBounds(new Rectangle(9, 98, 278, 21));
    jTextFieldParameter_b.addActionListener(new FrameSerie11_jTextFieldParameter_b_actionAdapter(this));
    jTextFieldParameter_b.addActionListener(new
                                      FrameSerie11_jTextFieldParameter_b_actionAdapter(this));
    jTextFieldParameter_b.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldParameter_b.setSelectionEnd(11);
    jTextFieldParameter_b.setNextFocusableComponent(null);
    jTextFieldParameter_b.setText(parameter_b.toString());
    jLabelParameter_b.setText("Parameter b");
    jLabelParameter_b.setBounds(new Rectangle(291, 101, 188, 15));
        jTextFieldPunkt_x.addActionListener(new
                                      FrameSerie11_jTextFieldPunkt_x_actionAdapter(this));
    jTextFieldPunkt_x.setHorizontalAlignment(SwingConstants.RIGHT);
    jTextFieldPunkt_x.setSelectionEnd(11);
    jTextFieldPunkt_x.setNextFocusableComponent(null);
    jTextFieldPunkt_x.setText(P_x.toString());
        jLabelPunkt_y.setBounds(new Rectangle(317, 240, 209, 15));
    jLabelPunkt_y.setText("Wahl der y-Komponente von P");
    jLabelPunkt_x.setText("x-Komponente von P");
    jLabelPunkt_x.setBounds(new Rectangle(317, 207, 209, 15));
        jTextPaneResultat_y.setBounds(new Rectangle(9, 446, 278, 21));
    jTextPaneResultat_y.setEditable(false);
    jTextPaneResultat_y.setBorder(BorderFactory.createEtchedBorder());
    jTextPaneResultat_y.setBackground(Color.lightGray);
    jLabelResultat_y.setBounds(new Rectangle(291, 449, 188, 15));
    jLabelResultat_y.setText("y-Komponente von R");
    jLabelResultat_x.setText("x-Komponente von R");
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
        jPanel1.add(jTextPaneResultat_x, null);
        jPanel1.add(jButtonStartA, null);
        jPanel1.add(jLabelResultat, null);
        jPanel1.add(jTextPaneResultat_y, null);
        jPanel1.add(jLabelResultat_x, null);
        jPanel1.add(jLabelResultat_y, null);
        jPanel1.add(jTextFieldPunkt_x, null);
        jPanel1.add(jTextPanePunkt_y1);
        jPanel1.add(jTextPanePunkt_y2);
        jPanel1.add(jRadioButtonPunkt_y1);
        jPanel1.add(jRadioButtonPunkt_y2);
        jPanel1.add(jTextFieldQunkt_x);
        jPanel1.add(jTextPaneQunkt_y1);
        jPanel1.add(jTextPaneQunkt_y2);
        jPanel1.add(jRadioButtonQunkt_y1);
        jPanel1.add(jRadioButtonQunkt_y2); // ContentPane
        jPanel1.add(jLabelPunkt_x, null);
        jPanel1.add(jLabelQunkt_x);
        jPanel1.add(jLabelPunkt_y, null);
        jPanel1.add(jLabelQunkt_y);
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
    if (! P_y.equals(BigInteger.ONE.negate())) {
        try {
          res = P_x.elliptAdd(P_y, Q_x, Q_y, primZahl_p, parameter_a, parameter_b);

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
    P_x = new BigInteger(jTextFieldPunkt_x.getText());
    computeP_y();
    Q_x = new BigInteger(jTextFieldQunkt_x.getText());
    computeQ_y();
  }

  void computeP_y() {
  	  if (P_x.equals(primZahl_p)) {
  	  	  jTextPanePunkt_y1.setText("Unendlich ferner Punkt O");
          jTextPanePunkt_y2.setText("");
          P_y = BigInteger.ZERO;
          return;
  	  }
  	  
      BigInteger ySquare = P_x.pow(3).mod(primZahl_p);
      ySquare = ySquare.add(parameter_a.multiply(P_x)).mod(primZahl_p);
      ySquare = ySquare.add(parameter_b).mod(primZahl_p);

      P_y1 = ySquare.myModSqrt(primZahl_p);
      
      if (P_y1.equals(BigInteger.ONE.negate())) {
    	  jTextPanePunkt_y1.setText("Keine Lösung!");
          jTextPanePunkt_y2.setText("");
          P_y = P_y1;
          return;
      }

      P_y2 = P_y1.negate().mod(primZahl_p);
      if (P_y1.pow(2).mod(primZahl_p).equals(ySquare)) {
          if (P_y1.compareTo(P_y2) > 0) {
              BigInteger swap = P_y1;
              P_y1 = P_y2;
              P_y2 = swap;
          }

          jTextPanePunkt_y1.setText(P_y1.toString());
          jTextPanePunkt_y2.setText(P_y2.toString());
          if (jRadioButtonPunkt_y1.isSelected()) {
              P_y = P_y1;
          }
          else {
              P_y = P_y2;
          }
      }
      else {
          jTextPanePunkt_y1.setText("Keine Lösung!");
          jTextPanePunkt_y2.setText("");
          P_y = BigInteger.ONE.negate();
      }
  }

  void computeQ_y() {
  	  if (Q_x.equals(primZahl_p)) {
  	  	  jTextPaneQunkt_y1.setText("Unendlich ferner Punkt O");
          jTextPaneQunkt_y2.setText("");
          Q_y = BigInteger.ZERO;
          return;
  	  }
  	  
      BigInteger ySquare = Q_x.pow(3).mod(primZahl_p);
      ySquare = ySquare.add(parameter_a.multiply(Q_x)).mod(primZahl_p);
      ySquare = ySquare.add(parameter_b).mod(primZahl_p);

      Q_y1 = ySquare.myModSqrt(primZahl_p);
      
      if (Q_y1.equals(BigInteger.ONE.negate())) {
    	  jTextPaneQunkt_y1.setText("Keine Lösung!");
          jTextPaneQunkt_y2.setText("");
          Q_y = Q_y1;
          return;
      }

      Q_y2 = Q_y1.negate().mod(primZahl_p);
      if (Q_y1.pow(2).mod(primZahl_p).equals(ySquare)) {
          if (Q_y1.compareTo(Q_y2) > 0) {
              BigInteger swap = Q_y1;
              Q_y1 = Q_y2;
              Q_y2 = swap;
          }

          jTextPaneQunkt_y1.setText(Q_y1.toString());
          jTextPaneQunkt_y2.setText(Q_y2.toString());
          if (jRadioButtonQunkt_y1.isSelected()) {
              Q_y = Q_y1;
          }
          else {
              Q_y = Q_y2;
          }
      }
      else {
          jTextPaneQunkt_y1.setText("Keine Lösung!");
          jTextPaneQunkt_y2.setText("");
          Q_y = BigInteger.ONE.negate();
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

    public void jRadioButtonQunkt_y1_actionPerformed(ActionEvent e) {
        jRadioButtonQunkt_y1.setSelected(true);
        jRadioButtonQunkt_y2.setSelected(false);
        updateFields();
    }

    public void jRadioButtonQunkt_y2_actionPerformed(ActionEvent e) {
        jRadioButtonQunkt_y1.setSelected(false);
        jRadioButtonQunkt_y2.setSelected(true);
        updateFields();
    }

    public void jTextFieldQunkt_x_actionPerformed(ActionEvent e) {
        updateFields();
        jTextFieldQunkt_x.selectAll();
    }
}


class FrameSerie11_jRadioButtonQunkt_y2_actionAdapter implements ActionListener {
    private FrameSerie11 adaptee;
    FrameSerie11_jRadioButtonQunkt_y2_actionAdapter(FrameSerie11 adaptee) {
        this.adaptee = adaptee;
    }

    public void actionPerformed(ActionEvent e) {
        adaptee.jRadioButtonQunkt_y2_actionPerformed(e);
    }
}


class FrameSerie11_jRadioButtonQunkt_y1_actionAdapter implements ActionListener {
    private FrameSerie11 adaptee;
    FrameSerie11_jRadioButtonQunkt_y1_actionAdapter(FrameSerie11 adaptee) {
        this.adaptee = adaptee;
    }

    public void actionPerformed(ActionEvent e) {
        adaptee.jRadioButtonQunkt_y1_actionPerformed(e);
    }
}


class FrameSerie11_jRadioButtonPunkt_y1_actionAdapter implements ActionListener {
    private FrameSerie11 adaptee;
    FrameSerie11_jRadioButtonPunkt_y1_actionAdapter(FrameSerie11 adaptee) {
        this.adaptee = adaptee;
    }

    public void actionPerformed(ActionEvent e) {
        adaptee.jRadioButtonPunkt_y1_actionPerformed(e);
    }
}


class FrameSerie11_jRadioButtonPunkt_y2_actionAdapter implements ActionListener {
    private FrameSerie11 adaptee;
    FrameSerie11_jRadioButtonPunkt_y2_actionAdapter(FrameSerie11 adaptee) {
        this.adaptee = adaptee;
    }

    public void actionPerformed(ActionEvent e) {
        adaptee.jRadioButtonPunkt_y2_actionPerformed(e);
    }
}


class FrameSerie11_jMenuDateiSchliessen_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie11 adaptee;

  FrameSerie11_jMenuDateiSchliessen_actionAdapter(FrameSerie11 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuDateiSchliessen_actionPerformed(e);
  }
}

class FrameSerie11_jButtonStartA_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie11 adaptee;

  FrameSerie11_jButtonStartA_actionAdapter(FrameSerie11 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jButtonStartA_actionPerformed(e);
  }
}

class FrameSerie11_jTextFieldPrimZahl_p_actionAdapter
    implements java.awt.event.ActionListener {
  FrameSerie11 adaptee;

  FrameSerie11_jTextFieldPrimZahl_p_actionAdapter(FrameSerie11 adaptee) {
    this.adaptee = adaptee;
  }

  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldPrimZahl_p_actionPerformed(e);
  }
}

class FrameSerie11_jTextFieldParameter_a_actionAdapter implements java.awt.event.ActionListener {
  FrameSerie11 adaptee;

  FrameSerie11_jTextFieldParameter_a_actionAdapter(FrameSerie11 adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldParameter_a_actionPerformed(e);
  }
}


class FrameSerie11_jTextFieldParameter_b_actionAdapter implements java.awt.event.ActionListener {
  FrameSerie11 adaptee;

  FrameSerie11_jTextFieldParameter_b_actionAdapter(FrameSerie11 adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldParameter_b_actionPerformed(e);
  }
}

class FrameSerie11_jTextFieldFaktor_n_actionAdapter implements java.awt.event.ActionListener {
  FrameSerie11 adaptee;

  FrameSerie11_jTextFieldFaktor_n_actionAdapter(FrameSerie11 adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldFaktor_n_actionPerformed(e);
  }
}

class FrameSerie11_jTextFieldPunkt_x_actionAdapter implements java.awt.event.ActionListener {
  FrameSerie11 adaptee;

  FrameSerie11_jTextFieldPunkt_x_actionAdapter(FrameSerie11 adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jTextFieldPunkt_x_actionPerformed(e);
  }
}


class FrameSerie11_jTextFieldQunkt_x_actionAdapter implements ActionListener {
    private FrameSerie11 adaptee;
    FrameSerie11_jTextFieldQunkt_x_actionAdapter(FrameSerie11 adaptee) {
        this.adaptee = adaptee;
    }

    public void actionPerformed(ActionEvent e) {
        adaptee.jTextFieldQunkt_x_actionPerformed(e);
    }
}
