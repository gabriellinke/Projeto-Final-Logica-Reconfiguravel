#!/usr/bin/env python3
from serverGui import ServerUI

import sys
import random
import matplotlib
import numpy as np
from numpy.fft import fft, ifft
matplotlib.use('Qt5Agg')

from PySide6.QtWidgets import QMainWindow, QApplication, QPushButton, QGridLayout, QWidget
from PySide6.QtCore import QTimer

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


class MainWindow(QMainWindow):

    def __init__(self, *args, **kwargs):
        super(MainWindow, self).__init__(*args, **kwargs)

        self.canvas = MplCanvas(self, width=10, height=4, dpi=100)
        # self.setCentralWidget(self.canvas)

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

        n_data = 50
        self.max_data = 500
        self.input_ydata = [int(e.strip()) for e in open("input.dat", "r").readlines()]
        self.input_xdata = list(range(len(self.input_ydata)))
        self.output_ydata = []
        self.output_xdata = list(range(len(self.output_ydata)))

        self._plot_input_ref = None
        self._plot_output_ref = None
        self.update_plot()

        self.show()

        # Setup a timer to trigger the redraw by calling update_plot.
        # self.timer = QTimer()
        # self.timer.setInterval(100)
        # self.timer.timeout.connect(self.update_plot)
        # self.timer.start()
        self.server.update.connect(self.update_plot)

    def update_plot(self, point=0):
        self.output_ydata.append(point)
        self.output_xdata.append(len(self.output_xdata)+1)
        # fillY = self.output_ydata + ([-50000]*(len(self.output_xdata) - len(self.output_ydata)))
        # print(len(fillY))

        if self._plot_input_ref is None:
            plot_refs = self.canvas.input_axes.plot(self.input_xdata, self.input_ydata, 'r')
            self._plot_input_ref = plot_refs[0]
        else:
            self._plot_input_ref.set_ydata(self.input_ydata)

        if self._plot_output_ref is None:
            plot_refs = self.canvas.output_axes.plot(self.output_xdata, self.output_ydata, 'b')
            self.canvas.output_axes.set_xlim(self.canvas.input_axes.get_xlim())
            self.canvas.output_axes.set_ylim(self.canvas.input_axes.get_ylim())
            self._plot_output_ref = plot_refs[0]
        else:
            self._plot_output_ref.set_ydata(self.output_ydata)
            self._plot_output_ref.set_xdata(self.output_xdata)

        # if(self.show_fft):
        #     sr = 44100
        #     X_in = fft(self.input_ydata)
        #     N = len(X_in)
        #     n = np.arange(N)
        #     T = N/sr
        #     freq = n/T
        #     self.canvas.input_axes.stem(freq, np.abs(X_in), 'r')
        #     X_out = fft(self.output_ydata)
        #     N = len(X_out)
        #     n = np.arange(N)
        #     T = N/sr
        #     freq = n/T
        #     self.canvas.output_axes.stem(freq, np.abs(X_out), 'b')
        # else:
        #     self.canvas.input_axes.plot(self.input_xdata, self.input_ydata, 'r')
        #     self.canvas.output_axes.plot(self.output_xdata, self.output_ydata, 'b')
        # Trigger the canvas to update and redraw.

        self.canvas.draw()

    def handleButton(self):
        if(self.show_fft):
            self.show_fft = False
            self.button.setText("FFT")
        else:
            self.show_fft = True
            self.button.setText("Tempo")



app = QApplication(sys.argv)
w = MainWindow()
app.exec()
