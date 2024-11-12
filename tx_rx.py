import serial
import time

def main():
    initialize()
    loop()

def initialize():
    global ser
    print("connecting...")
    time.sleep(1)
    ser = serial.Serial('/dev/tty.usbmodem141102', baudrate=115200, bytesize=serial.EIGHTBITS, parity=serial.PARITY_NONE, stopbits=serial.STOPBITS_ONE)

    time.sleep(1)
    print("connected")

def loop():
    tx = True
    rx = False

    idk = True
    loops = 0
    sleep1 = 1
    sleep2 = 1
    intToBytes = 312

    while (tx):
        if idk:
            # intToBytes += 10000
            byte_to_send = intToBytes.to_bytes(4, 'little')  # Converts the integer 25 to a single byte - multiply by 10^6 on the other side
        else:
            byte_to_send = bytes([0])
        

        ser.write(byte_to_send)
# np.u int 8
        print("byte sent:")
        print(byte_to_send)

        
        time.sleep(sleep1 if loops < 3 else sleep2)

        loops += 1

    
    while (rx):
        if (ser.in_waiting > 0):
            incoming_byte = ser.read(1)
            print("something came: ", incoming_byte)
        ser.reset_output_buffer()


if __name__ == '__main__' :
    print("hi")
    main()




        # if idk:
        #     intToBytes = 2
        #     byte_to_send = intToBytes.to_bytes(1, 'little')  # Converts the integer 25 to a single byte - multiply by 10^6 on the other side
        # else:
        #     byte_to_send = bytes([0])
        # ser.write(byte_to_send)
        # print("byte sent:")
        # print(byte_to_send)

        
        # time.sleep(sleep1 if loops < 3 else sleep2)

        # loops += 1
