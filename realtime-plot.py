#!/usr/bin/env python3
import sys
import random
import matplotlib
import numpy as np
from numpy.fft import fft, ifft
matplotlib.use('Qt5Agg')

from PySide6.QtWidgets import QMainWindow, QApplication, QPushButton, QVBoxLayout, QWidget
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
        self.show_fft = False
        self.button.clicked.connect(self.handleButton)
        layout = QVBoxLayout()
        layout.addWidget(self.button)
        layout.addWidget(self.canvas)
        widget = QWidget()
        widget.setLayout(layout)
        self.setCentralWidget(widget)

        n_data = 50
        self.max_data = 500
        self.output_xdata = list(range(n_data))
        self.input_ydata = [int(e.strip()) for e in open("input.dat", "r").readlines()]
        self.input_xdata = list(range(len(self.input_ydata)))
        self.output_ydata = [random.randint(0, 10) for i in range(n_data)]

        self._plot_input_ref = None
        self._plot_output_ref = None
        self.update_plot()

        self.show()

        # Setup a timer to trigger the redraw by calling update_plot.
        self.timer = QTimer()
        self.timer.setInterval(100)
        self.timer.timeout.connect(self.update_plot)
        self.timer.start()

    def update_plot(self):
        # if(len(self.input_ydata) < self.max_data):
            # Drop off the first y element, append a new one.
            # self.input_xdata = self.input_xdata + [len(self.input_xdata)+1]
            # self.input_ydata = self.input_ydata + [random.randint(0, 10)]

        self.output_ydata = self.output_ydata[1:] + [random.randint(0, 10)]

        self.canvas.input_axes.cla()  # Clear the canvas.
        self.canvas.output_axes.cla()  # Clear the canvas.
        if(self.show_fft):
            sr = 100
            X_in = fft(self.input_ydata)
            N = len(X_in)
            n = np.arange(N)
            T = N/sr
            freq = n/T
            self.canvas.input_axes.stem(freq, np.abs(X_in), 'r')
            X_out = fft(self.output_ydata)
            N = len(X_out)
            n = np.arange(N)
            T = N/sr
            freq = n/T
            self.canvas.output_axes.stem(freq, np.abs(X_out), 'b')
        else:
            self.canvas.input_axes.plot(self.input_xdata, self.input_ydata, 'r')
            self.canvas.output_axes.plot(self.output_xdata, self.output_ydata, 'b')
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
