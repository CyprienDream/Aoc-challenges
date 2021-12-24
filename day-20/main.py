import sys
import numpy


def parse_input(path):
    lines = open(path).read().replace('#', '1').replace('.', '0').strip().split('\n')
    rows = [[int(x) for x in line] for line in lines if line.strip()]
    lut, image_rows = rows[0], rows[1:]
    lut = numpy.array(lut).reshape([2] * 9)
    image = numpy.array(image_rows).transpose()
    return lut, image


def enhance_image(image, lut, pad_with):
    new_image = numpy.pad(image, 1, constant_values=pad_with)
    tmp_image = numpy.pad(new_image, 1, constant_values=pad_with)
    for x in range(len(new_image)):
        for y in range(len(new_image[0])):
            segment = tmp_image[x : x + 3, y : y + 3]
            new_image[x, y] = lut[tuple(segment.transpose().flatten())]
    return new_image, lut[(pad_with,) * 9]


def main(input_file):
    lut, image = parse_input(input_file)
    pad_with = 0
    for i in range(50):
        image, pad_with = enhance_image(image, lut, pad_with)
        if i == 1:
            print("Part 1:", numpy.count_nonzero(image))
    print("Part 2:", numpy.count_nonzero(image))


if __name__ == '__main__':
    main(sys.argv[1])
