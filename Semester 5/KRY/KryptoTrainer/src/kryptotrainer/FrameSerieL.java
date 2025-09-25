package kryptotrainer;

import javax.swing.*;
import java.awt.*;

/**
 * <p>Title: KryptoTrainer</p>
 * <p>Description: Übungsumgebung für das Wahlfach Kryptologie</p>
 * <p>Copyright: Copyright (c) 2006 / Samuel Beer</p>
 * <p>Company: Zürcher Hochschule Winterthur</p>
 * @author Samuel Beer
 * @version 1.0
 */

public class FrameSerieL extends JFrame {
  BorderLayout borderLayout1 = new BorderLayout();

  public FrameSerieL() {
    try {
      jbInit();
    }
    catch(Exception ex) {
      ex.printStackTrace();
    }
  }

  void jbInit() throws Exception {
    this.getContentPane().setLayout(borderLayout1);
  }
}
