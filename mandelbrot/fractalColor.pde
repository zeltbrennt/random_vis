class fractalColor {

    color[] colors = new color[] {
        color(66, 30, 15),
        color(25, 7, 26),
        color(9, 1, 47),
        color(4, 4, 73),
        color(0, 7, 100),
        color(12, 44,138),
        color(24,82,177),
        color(57,125,209),
        color(134, 181, 229),
        color(211, 236, 248),
        color(241, 233, 191),
        color(248, 201, 95),
        color(255, 170, 0),
        color(204, 128, 0),
        color(153, 87, 0),
        color(106, 52, 3)
    };

    color getColor(int i) {
        return colors[i];
    }
}