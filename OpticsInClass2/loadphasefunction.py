def load_phase_fn(filename):

    file = open(filename, 'r')

    start = 13
    end = 7013

    x_data = []
    y_data = []


    #load the data from the file
    for i, line in enumerate(file):
        if i < start:
            continue
        if i > end:
            break
        
        split_line = line.split(" ")

        x_data.append(float(split_line[1]))
        y_data.append(float(split_line[13]))

    return x_data, y_data