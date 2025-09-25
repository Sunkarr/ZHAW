package kryptotrainer;

import java.awt.*;
import java.awt.event.*;
import javax.swing.*;

/**
 * <p>Title: KryptoTrainer</p>
 * <p>Description: Übungsumgebung für das Wahlfach Kryptologie</p>
 * <p>Copyright: Copyright (c) 2006 / Samuel Beer</p>
 * <p>Company: Zürcher Fachhochschule Winterthur</p>
 * @author Samuel Beer
 * @version 1.0
 */

public class FrameHaupt extends JFrame {
  JButton jButtonSerie1 = new JButton();
  JButton jButtonSerie2 = new JButton();
  JButton jButtonSerie3 = new JButton();
  JButton jButtonSerie4 = new JButton();
  JButton jButtonSerie5 = new JButton();
  JButton jButtonSerie6 = new JButton();
  JButton jButtonSerie7 = new JButton();
  JButton jButtonSerie8 = new JButton();
  JButton jButtonSerie9 = new JButton();
  JButton jButtonSerie10 = new JButton();
  JButton jButtonSerie11 = new JButton();
  JButton jButtonSerie12 = new JButton();
  JButton jButtonSerie13 = new JButton();
  JButton jButtonSerie14 = new JButton();
  JButton jButtonSerie15 = new JButton();
  JButton jButtonSerie16 = new JButton();

  JMenuBar jMenuBar1 = new JMenuBar();
  JMenu jMenuDatei = new JMenu();
  JMenuItem jMenuDateiSchliessen = new JMenuItem();
  JMenu jMenuTestumgebungen = new JMenu();
  JMenuItem jMenuTestumgebungenSerie1 = new JMenuItem();
  JMenuItem jMenuTestumgebungenSerie2 = new JMenuItem();
  JMenuItem jMenuTestumgebungenSerie3 = new JMenuItem();
  JMenuItem jMenuTestumgebungenSerie4 = new JMenuItem();
  JMenuItem jMenuTestumgebungenSerie5 = new JMenuItem();
  JMenuItem jMenuTestumgebungenSerie6 = new JMenuItem();
  JMenuItem jMenuTestumgebungenSerie7 = new JMenuItem();
  JMenuItem jMenuTestumgebungenSerie8 = new JMenuItem();
  JMenuItem jMenuTestumgebungenSerie9 = new JMenuItem();
  JMenuItem jMenuTestumgebungenSerie10 = new JMenuItem();
  JMenuItem jMenuTestumgebungenSerie11 = new JMenuItem();
  JMenuItem jMenuTestumgebungenSerie12 = new JMenuItem();
  JMenuItem jMenuTestumgebungenSerie13 = new JMenuItem();
  JMenuItem jMenuTestumgebungenSerie14 = new JMenuItem();
  JMenuItem jMenuTestumgebungenSerie15 = new JMenuItem();
  JMenuItem jMenuTestumgebungenSerie16 = new JMenuItem();
  JMenu jMenuHilfe = new JMenu();
  JMenuItem jMenuHilfeInfo = new JMenuItem();

  JPanel contentPane;
  JPanel jPanel1 = new JPanel();
    JLabel jLabelHintergrund = new JLabel();

  ImageIcon image1 = new ImageIcon();

  FrameSerie1 frameSerie1 = null;
  FrameSerie2 frameSerie2 = null;
  FrameSerie3 frameSerie3 = null;
  FrameSerie4 frameSerie4 = null;
  FrameSerie5 frameSerie5 = null;
  FrameSerie6 frameSerie6 = null;
  FrameSerie7 frameSerie7 = null;
  FrameSerie8 frameSerie8 = null;
  FrameSerie9 frameSerie9 = null;
  FrameSerie10 frameSerie10 = null;
  FrameSerie11 frameSerie11 = null;
  FrameSerie12 frameSerie12 = null;
  FrameSerie13 frameSerie13 = null;

  final String[] PraktNum = {"Prakt. 2",
                             "Prakt. 4.1",
                             "Prakt. 4.2",
                             "Prakt. 6",
                             "Prakt. 7",
                             "Prakt. 8.1",
                             "Prakt. 8.2",
                             "Prakt. 10.1",
                             "Prakt. 10.2",
                             "Prakt. 12.1",
                             "Prakt. 12.2",
                             "Prakt. 14.1",
                             "Prakt. 14.2",
                             "",
                             "",
                             "",
                             "",
                             };

  final int INITIAL_OFFSET_X=50;
  final int INITIAL_OFFSET_Y=50;
  int offsetX=INITIAL_OFFSET_X;
  int offsetY=INITIAL_OFFSET_Y;
    GridLayout gridLayout1 = new GridLayout();
    //Construct the frame
  public FrameHaupt() {
    enableEvents(AWTEvent.WINDOW_EVENT_MASK);
    try {
      jbInit();
    }
    catch(Exception e) {
      e.printStackTrace();
    }
  }

  //Component initialization
  private void jbInit() throws Exception  {
    contentPane = (JPanel) this.getContentPane();
    contentPane.setLayout(gridLayout1);
    this.setSize(new Dimension(680, 477));
    this.setTitle("KryptoTrainer");
        gridLayout1.setColumns(1);
        contentPane.add(jPanel1, null);

    jButtonSerie1.setText(PraktNum[0]);
    jButtonSerie2.setText(PraktNum[1]);
    jButtonSerie3.setText(PraktNum[2]);
    jButtonSerie4.setText(PraktNum[3]);
    jButtonSerie5.setText(PraktNum[4]);
    jButtonSerie6.setText(PraktNum[5]);
    jButtonSerie7.setText(PraktNum[6]);
    jButtonSerie8.setText(PraktNum[7]);
    jButtonSerie9.setText(PraktNum[8]);
    jButtonSerie10.setText(PraktNum[9]);
    jButtonSerie11.setText(PraktNum[10]);
    jButtonSerie12.setText(PraktNum[11]);
    jButtonSerie13.setText(PraktNum[12]);
        
    jButtonSerie1.setBounds(new Rectangle(61, 121, 121, 25));
    jButtonSerie1.addActionListener(new FrameHaupt_jButtonSerie1_actionAdapter(this));
    jButtonSerie2.setBounds(new Rectangle(207, 121, 121, 25));
    jButtonSerie2.addActionListener(new FrameHaupt_jButtonSerie2_actionAdapter(this));
    jButtonSerie3.setBounds(new Rectangle(352, 121, 121, 25));
    jButtonSerie3.addActionListener(new FrameHaupt_jButtonSerie3_actionAdapter(this));
    jButtonSerie4.setBounds(new Rectangle(498, 121, 121, 25));
    jButtonSerie4.addActionListener(new FrameHaupt_jButtonSerie4_actionAdapter(this));
    jButtonSerie5.setBounds(new Rectangle(61, 162, 121, 25));
    jButtonSerie5.addActionListener(new FrameHaupt_jButtonSerie5_actionAdapter(this));
    jButtonSerie6.setBounds(new Rectangle(207, 162, 121, 25));
    jButtonSerie6.addActionListener(new FrameHaupt_jButtonSerie6_actionAdapter(this));
    jButtonSerie7.setBounds(new Rectangle(352, 162, 121, 25));
    jButtonSerie7.addActionListener(new FrameHaupt_jButtonSerie7_actionAdapter(this));
    jButtonSerie8.setBounds(new Rectangle(498, 162, 121, 25));
    jButtonSerie8.addActionListener(new FrameHaupt_jButtonSerie8_actionAdapter(this));
    jButtonSerie9.setBounds(new Rectangle(61, 203, 121, 25));
    jButtonSerie9.addActionListener(new FrameHaupt_jButtonSerie9_actionAdapter(this));
    jButtonSerie10.setBounds(new Rectangle(207, 203, 121, 25));
    jButtonSerie10.addActionListener(new FrameHaupt_jButtonSerie10_actionAdapter(this));
    jButtonSerie11.setBounds(new Rectangle(352, 203, 121, 25));
    jButtonSerie11.addActionListener(new FrameHaupt_jButtonSerie11_actionAdapter(this));
    jButtonSerie12.setBounds(new Rectangle(498, 203, 121, 25));
    jButtonSerie12.addActionListener(new FrameHaupt_jButtonSerie12_actionAdapter(this));
    jButtonSerie13.setBounds(new Rectangle(61, 244, 121, 25));
    jButtonSerie13.addActionListener(new FrameHaupt_jButtonSerie13_actionAdapter(this));
    
    jLabelHintergrund.setText("KryptoTrainer");
    image1 = new ImageIcon(kryptotrainer.FrameHaupt.class.getResource("logoZHAW.jpg"));
    jLabelHintergrund.setIcon(image1);
    jLabelHintergrund.setBackground(Color.white);
    jLabelHintergrund.setFont(new java.awt.Font("Arial", 0, 40));
    jLabelHintergrund.setAlignmentX((float) 0.5);
    jLabelHintergrund.setHorizontalAlignment(SwingConstants.CENTER);
    jLabelHintergrund.setHorizontalTextPosition(SwingConstants.CENTER);
    jLabelHintergrund.setVerticalTextPosition(SwingConstants.TOP);
    jLabelHintergrund.setVerticalAlignment(SwingConstants.TOP);
    jLabelHintergrund.setBounds(new Rectangle(132, 44, 391, 377));
    jLabelHintergrund.setIconTextGap(180);

    jMenuDatei.setText("Datei");
    jMenuDateiSchliessen.setText("Schliessen");
    jMenuDateiSchliessen.addActionListener(new FrameHaupt_jMenuDateiSchliessen_ActionAdapter(this));

    jMenuTestumgebungen.setText("Testumgebungen");
    jMenuTestumgebungenSerie1.addActionListener(new FrameHaupt_jMenuTestumgebungenSerie1_actionAdapter(this));
    jMenuTestumgebungenSerie2.addActionListener(new FrameHaupt_jMenuTestumgebungenSerie2_actionAdapter(this));
    jMenuTestumgebungenSerie3.addActionListener(new FrameHaupt_jMenuTestumgebungenSerie3_actionAdapter(this));
    jMenuTestumgebungenSerie4.addActionListener(new FrameHaupt_jMenuTestumgebungenSerie4_actionAdapter(this));
    jMenuTestumgebungenSerie5.addActionListener(new FrameHaupt_jMenuTestumgebungenSerie5_actionAdapter(this));
    jMenuTestumgebungenSerie6.addActionListener(new FrameHaupt_jMenuTestumgebungenSerie6_actionAdapter(this));
    jMenuTestumgebungenSerie7.addActionListener(new FrameHaupt_jMenuTestumgebungenSerie7_actionAdapter(this));
    jMenuTestumgebungenSerie8.addActionListener(new FrameHaupt_jMenuTestumgebungenSerie8_actionAdapter(this));
    jMenuTestumgebungenSerie9.addActionListener(new FrameHaupt_jMenuTestumgebungenSerie9_actionAdapter(this));
    jMenuTestumgebungenSerie10.addActionListener(new FrameHaupt_jMenuTestumgebungenSerie10_actionAdapter(this));
    jMenuTestumgebungenSerie11.addActionListener(new FrameHaupt_jMenuTestumgebungenSerie11_actionAdapter(this));
    jMenuTestumgebungenSerie12.addActionListener(new FrameHaupt_jMenuTestumgebungenSerie12_actionAdapter(this));
    jMenuTestumgebungenSerie13.addActionListener(new FrameHaupt_jMenuTestumgebungenSerie13_actionAdapter(this));
        
    
    jMenuTestumgebungenSerie1.setText(PraktNum[0]);
    jMenuTestumgebungenSerie2.setText(PraktNum[1]);
    jMenuTestumgebungenSerie3.setText(PraktNum[2]);
    jMenuTestumgebungenSerie4.setText(PraktNum[3]);
    jMenuTestumgebungenSerie5.setText(PraktNum[4]);
    jMenuTestumgebungenSerie6.setText(PraktNum[5]);
    jMenuTestumgebungenSerie7.setText(PraktNum[6]);
    jMenuTestumgebungenSerie8.setText(PraktNum[7]);
    jMenuTestumgebungenSerie9.setText(PraktNum[8]);
    jMenuTestumgebungenSerie10.setText(PraktNum[9]);
    jMenuTestumgebungenSerie11.setText(PraktNum[10]);
    jMenuTestumgebungenSerie12.setText(PraktNum[11]);
    jMenuTestumgebungenSerie13.setText(PraktNum[12]);
    jMenuTestumgebungenSerie14.setText(PraktNum[13]);
    jMenuTestumgebungenSerie15.setText(PraktNum[14]);
    jMenuTestumgebungenSerie16.setText(PraktNum[15]);

    jMenuHilfe.setText("Hilfe");
    jMenuHilfeInfo.setText("Info");
    jMenuHilfeInfo.addActionListener(new FrameHaupt_jMenuHilfeInfo_ActionAdapter(this));

    jMenuDatei.add(jMenuDateiSchliessen);
    jMenuTestumgebungen.add(jMenuTestumgebungenSerie1);
    jMenuTestumgebungen.add(jMenuTestumgebungenSerie2);
    jMenuTestumgebungen.add(jMenuTestumgebungenSerie3);
    jMenuTestumgebungen.add(jMenuTestumgebungenSerie4);
    jMenuTestumgebungen.add(jMenuTestumgebungenSerie5);
    jMenuTestumgebungen.add(jMenuTestumgebungenSerie6);
    jMenuTestumgebungen.add(jMenuTestumgebungenSerie7);
    jMenuTestumgebungen.add(jMenuTestumgebungenSerie8);
    jMenuTestumgebungen.add(jMenuTestumgebungenSerie9);
    jMenuTestumgebungen.add(jMenuTestumgebungenSerie10);
    jMenuTestumgebungen.add(jMenuTestumgebungenSerie11);
    jMenuTestumgebungen.add(jMenuTestumgebungenSerie12);
    jMenuTestumgebungen.add(jMenuTestumgebungenSerie13);
    jMenuTestumgebungen.add(jMenuTestumgebungenSerie14);
    jMenuTestumgebungen.add(jMenuTestumgebungenSerie15);
    jMenuTestumgebungen.add(jMenuTestumgebungenSerie16);
    jMenuHilfe.add(jMenuHilfeInfo);

    jMenuBar1.add(jMenuDatei);
    jMenuBar1.add(jMenuTestumgebungen);
    jMenuBar1.add(jMenuHilfe);
    this.setJMenuBar(jMenuBar1);

    jPanel1.setBackground(Color.white);
    jPanel1.setAlignmentX((float) 0.5);
        jPanel1.setLayout(null);
        jPanel1.add(jLabelHintergrund, null);
        jPanel1.add(jButtonSerie1, null);
        jPanel1.add(jButtonSerie2, null);
        jPanel1.add(jButtonSerie3, null);
        jPanel1.add(jButtonSerie4, null);
        jPanel1.add(jButtonSerie5, null);
        jPanel1.add(jButtonSerie6, null);
        jPanel1.add(jButtonSerie7, null);
        jPanel1.add(jButtonSerie8, null);
        jPanel1.add(jButtonSerie9, null);
        jPanel1.add(jButtonSerie10, null);
        jPanel1.add(jButtonSerie11, null);
        jPanel1.add(jButtonSerie12, null);
        jPanel1.add(jButtonSerie13, null);
        jPanel1.add(jButtonSerie14, null);
        jPanel1.add(jButtonSerie15, null);
        jPanel1.add(jButtonSerie16, null);
        
        JButton buttonLeer1 = new JButton();
        buttonLeer1.setBounds(new Rectangle(498, 203, 121, 25));
        buttonLeer1.setBounds(207, 245, 121, 25);
        jPanel1.add(buttonLeer1);

        JButton buttonLeer2 = new JButton();
        buttonLeer2.setBounds(new Rectangle(498, 203, 121, 25));
        buttonLeer2.setBounds(352, 245, 121, 25);
        jPanel1.add(buttonLeer2);
        
        JButton buttonLeer3 = new JButton();
        buttonLeer3.setBounds(new Rectangle(498, 203, 121, 25));
        buttonLeer3.setBounds(498, 245, 121, 25);
        jPanel1.add(buttonLeer3);
    }

  //Menu Datei | Schliessen action performed
  public void jMenuDateiSchliessen_actionPerformed(ActionEvent e) {
    System.exit(0);
  }

  //Menu Hilfe | Info action performed
  public void jMenuHilfeInfo_actionPerformed(ActionEvent e) {
    FrameHaupt_AboutBox dlg = new FrameHaupt_AboutBox(this);
    Dimension dlgSize = dlg.getPreferredSize();
    Dimension frmSize = getSize();
    Point loc = getLocation();
    dlg.setLocation((frmSize.width - dlgSize.width) / 2 + loc.x, (frmSize.height - dlgSize.height) / 2 + loc.y);
    dlg.setModal(true);
    dlg.pack();
    dlg.show();
  }

  //Overridden so we can exit when window is closed
  protected void processWindowEvent(WindowEvent e) {
    super.processWindowEvent(e);
    if (e.getID() == WindowEvent.WINDOW_CLOSING) {
      jMenuDateiSchliessen_actionPerformed(null);
    }
  }

  private void setNewOffset() {
    offsetX = offsetX + INITIAL_OFFSET_X;
    offsetY = offsetY + INITIAL_OFFSET_Y;

    Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
    if ((offsetX > screenSize.width/4) || (offsetY > screenSize.height/4)) {
      offsetX = INITIAL_OFFSET_X;
      offsetY = INITIAL_OFFSET_Y;
    }
  }

  //Menu Testumgebungen | Serie 1 action performed
  void jMenuTestumgebungenSerie1_actionPerformed(ActionEvent e) {
    if (frameSerie1 != null) {
      frameSerie1.dispose();
    }
    frameSerie1 = new FrameSerie1();
    frameSerie1.validate();
    frameSerie1.setLocation(offsetX, offsetY);
    frameSerie1.setVisible(true);
    setNewOffset();
  }

  //Menu Testumgebungen | Serie 2 action performed
  void jMenuTestumgebungenSerie2_actionPerformed(ActionEvent e) {
    if (frameSerie2 != null) {
      frameSerie2.dispose();
    }
    frameSerie2 = new FrameSerie2();
    frameSerie2.validate();
    frameSerie2.setLocation(offsetX, offsetY);
    frameSerie2.setVisible(true);
    setNewOffset();
  }

  //Menu Testumgebungen | Serie 3 action performed
  void jMenuTestumgebungenSerie3_actionPerformed(ActionEvent e) {
    if (frameSerie3 != null) {
      frameSerie3.dispose();
    }
    frameSerie3 = new FrameSerie3();
    frameSerie3.validate();
    frameSerie3.setLocation(offsetX, offsetY);
    frameSerie3.setVisible(true);
    setNewOffset();
  }

  //Menu Testumgebungen | Serie 4 action performed
  void jMenuTestumgebungenSerie4_actionPerformed(ActionEvent e) {
    if (frameSerie4 != null) {
      frameSerie4.dispose();
    }
    frameSerie4 = new FrameSerie4();
    frameSerie4.validate();
    frameSerie4.setLocation(offsetX, offsetY);
    frameSerie4.setVisible(true);
    setNewOffset();
  }

  //Menu Testumgebungen | Serie 5 action performed
  void jMenuTestumgebungenSerie5_actionPerformed(ActionEvent e) {
    if (frameSerie5 != null) {
      frameSerie5.dispose();
    }
    frameSerie5 = new FrameSerie5();
    frameSerie5.validate();
    frameSerie5.setLocation(offsetX, offsetY);
    frameSerie5.setVisible(true);
    setNewOffset();
  }

  //Menu Testumgebungen | Serie 6 action performed
  void jMenuTestumgebungenSerie6_actionPerformed(ActionEvent e) {
    if (frameSerie6 != null) {
      frameSerie6.dispose();
    }
    frameSerie6 = new FrameSerie6();
    frameSerie6.validate();
    frameSerie6.setLocation(offsetX, offsetY);
    frameSerie6.setVisible(true);
    setNewOffset();
  }

  //Menu Testumgebungen | Serie 7 action performed
  void jMenuTestumgebungenSerie7_actionPerformed(ActionEvent e) {
    if (frameSerie7 != null) {
      frameSerie7.dispose();
    }
    frameSerie7 = new FrameSerie7();
    frameSerie7.validate();
    frameSerie7.setLocation(offsetX, offsetY);
    frameSerie7.setVisible(true);
    setNewOffset();
  }

  //Menu Testumgebungen | Serie 8 action performed
  void jMenuTestumgebungenSerie8_actionPerformed(ActionEvent e) {
    if (frameSerie8 != null) {
      frameSerie8.dispose();
    }
    frameSerie8 = new FrameSerie8();
    frameSerie8.validate();
    frameSerie8.setLocation(offsetX, offsetY);
    frameSerie8.setVisible(true);
    setNewOffset();
  }

  //Menu Testumgebungen | Serie 9 action performed
  void jMenuTestumgebungenSerie9_actionPerformed(ActionEvent e) {
    if (frameSerie9 != null) {
      frameSerie9.dispose();
    }
    frameSerie9 = new FrameSerie9();
    frameSerie9.validate();
    frameSerie9.setLocation(offsetX, offsetY);
    frameSerie9.setVisible(true);
    setNewOffset();
  }

  //Menu Testumgebungen | Serie 10 action performed
  void jMenuTestumgebungenSerie10_actionPerformed(ActionEvent e) {
    if (frameSerie10 != null) {
      frameSerie10.dispose();
    }
    frameSerie10 = new FrameSerie10();
    frameSerie10.validate();
    frameSerie10.setLocation(offsetX, offsetY);
    frameSerie10.setVisible(true);
    setNewOffset();
  }

  //Menu Testumgebungen | Serie 11 action performed
  void jMenuTestumgebungenSerie11_actionPerformed(ActionEvent e) {
    if (frameSerie11 != null) {
      frameSerie11.dispose();
    }
    frameSerie11 = new FrameSerie11();
    frameSerie11.validate();
    frameSerie11.setLocation(offsetX, offsetY);
    frameSerie11.setVisible(true);
    setNewOffset();
  }

  //Menu Testumgebungen | Serie 12 action performed
  void jMenuTestumgebungenSerie12_actionPerformed(ActionEvent e) {
    if (frameSerie12 != null) {
      frameSerie12.dispose();
    }
    frameSerie12 = new FrameSerie12();
    frameSerie12.validate();
    frameSerie12.setLocation(offsetX, offsetY);
    frameSerie12.setVisible(true);
    setNewOffset();
  }
  
  //Menu Testumgebungen | Serie 13 action performed
  
  void jMenuTestumgebungenSerie13_actionPerformed(ActionEvent e) {
	    if (frameSerie13 != null) {
	      frameSerie13.dispose();
	    }
	    frameSerie13 = new FrameSerie13();
	    frameSerie13.validate();
	    frameSerie13.setLocation(offsetX, offsetY);
	    frameSerie13.setVisible(true);
	    setNewOffset();
	  }
}

class FrameHaupt_jMenuDateiSchliessen_ActionAdapter implements ActionListener {
  FrameHaupt adaptee;

  FrameHaupt_jMenuDateiSchliessen_ActionAdapter(FrameHaupt adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuDateiSchliessen_actionPerformed(e);
  }
}

class FrameHaupt_jMenuHilfeInfo_ActionAdapter implements ActionListener {
  FrameHaupt adaptee;

  FrameHaupt_jMenuHilfeInfo_ActionAdapter(FrameHaupt adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuHilfeInfo_actionPerformed(e);
  }
}

//Menu Testumgebungen | Serie 1 action adapter
class FrameHaupt_jMenuTestumgebungenSerie1_actionAdapter implements java.awt.event.ActionListener {
  FrameHaupt adaptee;

  FrameHaupt_jMenuTestumgebungenSerie1_actionAdapter(FrameHaupt adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuTestumgebungenSerie1_actionPerformed(e);
  }
}

class FrameHaupt_jButtonSerie1_actionAdapter implements java.awt.event.ActionListener {
  FrameHaupt adaptee;

  FrameHaupt_jButtonSerie1_actionAdapter(FrameHaupt adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuTestumgebungenSerie1_actionPerformed(e);
  }
}

//Menu Testumgebungen | Serie 2 action adapter
class FrameHaupt_jMenuTestumgebungenSerie2_actionAdapter implements java.awt.event.ActionListener {
  FrameHaupt adaptee;

  FrameHaupt_jMenuTestumgebungenSerie2_actionAdapter(FrameHaupt adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuTestumgebungenSerie2_actionPerformed(e);
  }
}

class FrameHaupt_jButtonSerie2_actionAdapter implements java.awt.event.ActionListener {
  FrameHaupt adaptee;

  FrameHaupt_jButtonSerie2_actionAdapter(FrameHaupt adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuTestumgebungenSerie2_actionPerformed(e);
  }
}

//Menu Testumgebungen | Serie 3 action adapter
class FrameHaupt_jMenuTestumgebungenSerie3_actionAdapter implements java.awt.event.ActionListener {
  FrameHaupt adaptee;

  FrameHaupt_jMenuTestumgebungenSerie3_actionAdapter(FrameHaupt adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuTestumgebungenSerie3_actionPerformed(e);
  }
}

class FrameHaupt_jButtonSerie3_actionAdapter implements java.awt.event.ActionListener {
  FrameHaupt adaptee;

  FrameHaupt_jButtonSerie3_actionAdapter(FrameHaupt adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuTestumgebungenSerie3_actionPerformed(e);
  }
}

//Menu Testumgebungen | Serie 4 action adapter
class FrameHaupt_jMenuTestumgebungenSerie4_actionAdapter implements java.awt.event.ActionListener {
  FrameHaupt adaptee;

  FrameHaupt_jMenuTestumgebungenSerie4_actionAdapter(FrameHaupt adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuTestumgebungenSerie4_actionPerformed(e);
  }
}

class FrameHaupt_jButtonSerie4_actionAdapter implements java.awt.event.ActionListener {
  FrameHaupt adaptee;

  FrameHaupt_jButtonSerie4_actionAdapter(FrameHaupt adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuTestumgebungenSerie4_actionPerformed(e);
  }
}

//Menu Testumgebungen | Serie 5 action adapter
class FrameHaupt_jMenuTestumgebungenSerie5_actionAdapter implements java.awt.event.ActionListener {
  FrameHaupt adaptee;

  FrameHaupt_jMenuTestumgebungenSerie5_actionAdapter(FrameHaupt adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuTestumgebungenSerie5_actionPerformed(e);
  }
}

class FrameHaupt_jButtonSerie5_actionAdapter implements java.awt.event.ActionListener {
  FrameHaupt adaptee;

  FrameHaupt_jButtonSerie5_actionAdapter(FrameHaupt adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuTestumgebungenSerie5_actionPerformed(e);
  }
}

//Menu Testumgebungen | Serie 6 action adapter
class FrameHaupt_jMenuTestumgebungenSerie6_actionAdapter implements java.awt.event.ActionListener {
  FrameHaupt adaptee;

  FrameHaupt_jMenuTestumgebungenSerie6_actionAdapter(FrameHaupt adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuTestumgebungenSerie6_actionPerformed(e);
  }
}

class FrameHaupt_jButtonSerie6_actionAdapter implements java.awt.event.ActionListener {
  FrameHaupt adaptee;

  FrameHaupt_jButtonSerie6_actionAdapter(FrameHaupt adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuTestumgebungenSerie6_actionPerformed(e);
  }
}

//Menu Testumgebungen | Serie 7 action adapter
class FrameHaupt_jMenuTestumgebungenSerie7_actionAdapter implements java.awt.event.ActionListener {
  FrameHaupt adaptee;

  FrameHaupt_jMenuTestumgebungenSerie7_actionAdapter(FrameHaupt adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuTestumgebungenSerie7_actionPerformed(e);
  }
}

class FrameHaupt_jButtonSerie7_actionAdapter implements java.awt.event.ActionListener {
  FrameHaupt adaptee;

  FrameHaupt_jButtonSerie7_actionAdapter(FrameHaupt adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuTestumgebungenSerie7_actionPerformed(e);
  }
}

//Menu Testumgebungen | Serie 8 action adapter
class FrameHaupt_jMenuTestumgebungenSerie8_actionAdapter implements java.awt.event.ActionListener {
  FrameHaupt adaptee;

  FrameHaupt_jMenuTestumgebungenSerie8_actionAdapter(FrameHaupt adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuTestumgebungenSerie8_actionPerformed(e);
  }
}

class FrameHaupt_jButtonSerie8_actionAdapter implements java.awt.event.ActionListener {
  FrameHaupt adaptee;

  FrameHaupt_jButtonSerie8_actionAdapter(FrameHaupt adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuTestumgebungenSerie8_actionPerformed(e);
  }
}

//Menu Testumgebungen | Serie 9 action adapter
class FrameHaupt_jMenuTestumgebungenSerie9_actionAdapter implements java.awt.event.ActionListener {
  FrameHaupt adaptee;

  FrameHaupt_jMenuTestumgebungenSerie9_actionAdapter(FrameHaupt adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuTestumgebungenSerie9_actionPerformed(e);
  }
}

class FrameHaupt_jButtonSerie9_actionAdapter implements java.awt.event.ActionListener {
  FrameHaupt adaptee;

  FrameHaupt_jButtonSerie9_actionAdapter(FrameHaupt adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuTestumgebungenSerie9_actionPerformed(e);
  }
}

//Menu Testumgebungen | Serie 10 action adapter
class FrameHaupt_jMenuTestumgebungenSerie10_actionAdapter implements java.awt.event.ActionListener {
  FrameHaupt adaptee;

  FrameHaupt_jMenuTestumgebungenSerie10_actionAdapter(FrameHaupt adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuTestumgebungenSerie10_actionPerformed(e);
  }
}

class FrameHaupt_jButtonSerie10_actionAdapter implements java.awt.event.ActionListener {
  FrameHaupt adaptee;

  FrameHaupt_jButtonSerie10_actionAdapter(FrameHaupt adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuTestumgebungenSerie10_actionPerformed(e);
  }
}

//Menu Testumgebungen | Serie 11 action adapter
class FrameHaupt_jMenuTestumgebungenSerie11_actionAdapter implements java.awt.event.ActionListener {
  FrameHaupt adaptee;

  FrameHaupt_jMenuTestumgebungenSerie11_actionAdapter(FrameHaupt adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuTestumgebungenSerie11_actionPerformed(e);
  }
}

class FrameHaupt_jButtonSerie11_actionAdapter implements java.awt.event.ActionListener {
  FrameHaupt adaptee;

  FrameHaupt_jButtonSerie11_actionAdapter(FrameHaupt adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuTestumgebungenSerie11_actionPerformed(e);
  }
}

//Menu Testumgebungen | Serie 12 action adapter
class FrameHaupt_jMenuTestumgebungenSerie12_actionAdapter implements java.awt.event.ActionListener {
  FrameHaupt adaptee;

  FrameHaupt_jMenuTestumgebungenSerie12_actionAdapter(FrameHaupt adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuTestumgebungenSerie12_actionPerformed(e);
  }
}

class FrameHaupt_jButtonSerie12_actionAdapter implements java.awt.event.ActionListener {
  FrameHaupt adaptee;

  FrameHaupt_jButtonSerie12_actionAdapter(FrameHaupt adaptee) {
    this.adaptee = adaptee;
  }
  public void actionPerformed(ActionEvent e) {
    adaptee.jMenuTestumgebungenSerie12_actionPerformed(e);
  }
}

//Menu Testumgebungen | Serie 13 action adapter
class FrameHaupt_jMenuTestumgebungenSerie13_actionAdapter implements java.awt.event.ActionListener {
FrameHaupt adaptee;

FrameHaupt_jMenuTestumgebungenSerie13_actionAdapter(FrameHaupt adaptee) {
this.adaptee = adaptee;
}
public void actionPerformed(ActionEvent e) {
adaptee.jMenuTestumgebungenSerie13_actionPerformed(e);
}
}

class FrameHaupt_jButtonSerie13_actionAdapter implements java.awt.event.ActionListener {
FrameHaupt adaptee;

FrameHaupt_jButtonSerie13_actionAdapter(FrameHaupt adaptee) {
this.adaptee = adaptee;
}
public void actionPerformed(ActionEvent e) {
adaptee.jMenuTestumgebungenSerie13_actionPerformed(e);
}
}









