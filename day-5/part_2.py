import argparse
import re
from collections import defaultdict
from typing import List, NamedTuple

# define regular expression for vent pattern
VENT_PATTERNS = r'([0-9]+),([0-9]+) -> ([0-9]+),([0-9]+)'

# define coordinate and line data structures
class Coordinate(NamedTuple):
    x: int
    y: int


class Line(NamedTuple):
    source: Coordinate
    destination: Coordinate

# counts how many lines pass through each point
def determine_overlapping_count(lines: List[Line]) -> int:
    """
        --> x
        .......1.. |
        ..1....1.. |
        ..1....1.. V
        .......1.. y
        .112111211
        ..........
        ..........
        ..........
        ..........
        222111....
    """
    count = 0
    points = defaultdict(lambda: 0)
    for line in lines:
        if line.source.x == line.destination.x or line.source.y == line.destination.y:
            #
            # Draw horizontal and vertical lines
            #
            horizontal = line.source.x == line.destination.x
            if line.source.x == line.destination.x:
                a, b = sorted([line.source.y, line.destination.y])
            elif line.source.y == line.destination.y:
                a, b = sorted([line.source.x, line.destination.x])

            for i in range(a, b+1):
                if horizontal:
                    pos = Coordinate(x=line.source.x, y=i)
                else:
                    pos = Coordinate(x=i, y=line.source.y)

                points[pos] += 1
                if points[pos] == 2:
                    count += 1
        else:
            #
            # Draw diagonal lines
            #
            diff = abs(line.source.x - line.destination.x)
            for i in range(diff+1):
                x = line.source.x
                y = line.source.y
                x += (i) if line.source.x < line.destination.x else -(i)
                y += (i) if line.source.y < line.destination.y else -(i)
                pos = Coordinate(x=x, y=y)

                points[pos] += 1
                if points[pos] == 2:
                    count += 1

    return count


if __name__ == '__main__':
    parser = argparse.ArgumentParser('AoC')
    parser.add_argument('-t', '--test', help="Run sample input and verify answers", action="store_true")
    args = parser.parse_args()

    lines = []
    with open('input.txt' if not args.test else 'sample.txt') as f:
        for data in f.readlines():
            match = re.match(VENT_PATTERNS, data.strip())
            lines.append(
                Line(
                    source=Coordinate(
                        x=int(match.group(1)),
                        y=int(match.group(2))
                    ),
                    destination=Coordinate(
                        x=int(match.group(3)),
                        y=int(match.group(4))
                    )
                )
            )

    points = determine_overlapping_count(lines)
    print(f'Overlapping point count: {points}')
