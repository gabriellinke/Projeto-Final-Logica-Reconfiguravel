#!/usr/bin/env python3
import sys
from PySide6.QtCore import Qt, Signal, QProcess
from PySide6.QtWidgets import QApplication, QWidget, QPushButton, QVBoxLayout, QPlainTextEdit

class ServerUI(QWidget):
    update = Signal(int)

    def __init__(self):
        super(ServerUI, self).__init__()
        self.initUI()
        self.p = None

    def initUI(self):
        self.btn = QPushButton("Start Server")
        self.btn.clicked.connect(self.start_server)
        self.text = QPlainTextEdit()
        self.text.setReadOnly(True)

        l = QVBoxLayout()
        l.addWidget(self.btn)
        l.addWidget(self.text)

        self.setLayout(l)

    def message(self, s):
        self.text.appendPlainText(s)

    def start_server(self):
        if self.p is None:  # No process running.
            self.p = QProcess()  # Keep a reference to the QProcess (e.g. on self) while it's running.
            self.p.readyReadStandardOutput.connect(self.handle_stdout)
            self.p.readyReadStandardError.connect(self.handle_stderr)
            self.p.finished.connect(self.process_finished)  # Clean up once complete.
            self.p.start("node", ['test.js'])
            self.btn.setText("Stop Server")
        else:
            self.btn.setText("Start Server")
            self.p.kill()
            self.p = None

    def handle_stderr(self):
        data = self.p.readAllStandardError()
        stderr = bytes(data).decode("utf8")
        # Extract progress if it is in the data.
        self.message(stderr)

    def handle_stdout(self):
        data = self.p.readAllStandardOutput()
        stdout = bytes(data).decode().replace("\x00", "")
        self.message(stdout)
        lines = stdout.split("\n")
        for val in lines:
            print("value: " + val)
            if val and (val[0].isdigit() or val[0] == '-'):
                point = int(val)
                print(f"captured point: {point}")
                self.update.emit(point)

    def process_finished(self):
        self.message("Process finished.")
        self.p = None
if __name__ == "__main__":
    app = QApplication(sys.argv)
    ex = ServerUI()
    ex.show()
    app.exec()
