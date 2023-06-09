#!/usr/bin/env python3
from serverGui import ServerUI

import sys
import matplotlib
import numpy as np
matplotlib.use('Qt5Agg')

from PySide6.QtWidgets import QMainWindow, QApplication, QPushButton, QGridLayout, QWidget

from matplotlib.backends.backend_qt5agg import FigureCanvasQTAgg as FigureCanvas
from matplotlib.figure import Figure


class MplCanvas(FigureCanvas):
    def __init__(self, parent=None, width=5, height=4, dpi=100):
        fig = Figure(figsize=(width, height), dpi=dpi)
        self.input_axes = fig.add_subplot(121)
        self.input_axes.set_title("Input Audio")
        self.output_axes = fig.add_subplot(122)
        self.output_axes.set_title("Output Audio")
        super(MplCanvas, self).__init__(fig)

    def clear(self):
        self.input_axes.cla()
        self.input_axes.set_title("Input Audio")
        self.output_axes.cla()
        self.output_axes.set_title("Output Audio")

class MainWindow(QMainWindow):

    def __init__(self, *args, **kwargs):
        super(MainWindow, self).__init__(*args, **kwargs)

        self.canvas = MplCanvas(self, width=10, height=4, dpi=100)

        self.button = QPushButton('FFT')
        self.server = ServerUI()
        self.show_fft = False
        self.button.clicked.connect(self.handleButton)
        layout = QGridLayout()
        layout.addWidget(self.server, 0, 0, 4, 2)
        layout.addWidget(self.button, 0, 5, 1, 1)
        layout.addWidget(self.canvas, 1, 2, 3, 6)
        widget = QWidget()
        widget.setLayout(layout)
        self.setCentralWidget(widget)

        self.sr = 44100
        self.input_ydata = [int(e.strip()) for e in open("input.dat", "r").readlines()]
        self.input_fft = np.fft.rfft(self.input_ydata)
        self.input_freq = np.fft.rfftfreq(len(self.input_ydata), d=1/self.sr)
        self.input_xdata = list(range(len(self.input_ydata)))
        self.output_ydata = []
        self.output_xdata = list(range(len(self.output_ydata)))

        self._plot_input_ref = None
        self._plot_output_ref = None
        self.update_plot()

        self.show()

        self.server.update.connect(self.update_plot)

    def update_plot(self, points=[]):
        self.output_ydata += points
        self.output_xdata = list(range(len(self.output_ydata)))

        if self.show_fft:
            self.canvas.input_axes.plot(self.input_freq, np.abs(self.input_fft), 'r')
        elif self._plot_input_ref is None:
            plot_refs = self.canvas.input_axes.plot(self.input_xdata, self.input_ydata, 'r')
            self._plot_input_ref = plot_refs[0]
        else:
            self._plot_input_ref.set_ydata(self.input_ydata)

        if self.show_fft and self.output_ydata:
            fft_data = np.fft.rfft(self.output_ydata) # rfft removes the mirrored part that fft generates
            fft_freq = np.fft.rfftfreq(len(self.output_ydata), d=1/self.sr)
            self.canvas.output_axes.plot(fft_freq, np.abs(fft_data), 'b')
            self.canvas.output_axes.set_xlim(self.canvas.input_axes.get_xlim())
            self.canvas.output_axes.set_ylim(self.canvas.input_axes.get_ylim())
        elif self._plot_output_ref is None:
            plot_refs = self.canvas.output_axes.plot(self.output_xdata, self.output_ydata, 'b')
            self.canvas.output_axes.set_xlim(self.canvas.input_axes.get_xlim())
            self.canvas.output_axes.set_ylim(self.canvas.input_axes.get_ylim())
            self._plot_output_ref = plot_refs[0]
        else:
            self._plot_output_ref.set_ydata(self.output_ydata)
            self._plot_output_ref.set_xdata(self.output_xdata)

        self.canvas.draw()

    def handleButton(self):
        if(self.show_fft):
            self.show_fft = False
            self.button.setText("FFT")
        else:
            self.show_fft = True
            self.button.setText("Tempo")
        self.canvas.clear()
        self._plot_input_ref = None
        self._plot_output_ref = None
        self.update_plot()


app = QApplication(sys.argv)
w = MainWindow()
app.exec()
