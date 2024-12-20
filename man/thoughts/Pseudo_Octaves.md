Pseudo Octaves
================

## Spatial -vs- Temporal

``` r
P1$frequencies[[1]]
#>  [1]  261.6256  497.0886  723.5927  944.4683 1161.2507 1374.8261 1585.7710
#>  [8] 1794.4897 2001.2815 2206.3764
```

    #>    harmonic_number evaluation_freq reference_freq pseudo_octave highest_freq
    #> 1                2        497.0886       261.6256      1.900000     2206.376
    #> 2                3        723.5927       261.6256      1.900000     2206.376
    #> 3                4        944.4683       261.6256      1.900000     2206.376
    #> 4                2        944.4683       497.0886      1.900000     2206.376
    #> 5                4       1161.2507       261.6256      2.106798     2206.376
    #> 6                5       1161.2507       261.6256      1.900000     2206.376
    #> 7                5       1374.8261       261.6256      2.043297     2206.376
    #> 8                6       1374.8261       261.6256      1.900000     2206.376
    #> 9                3       1374.8261       497.0886      1.900000     2206.376
    #> 10               2       1374.8261       723.5927      1.900000     2206.376
    #> 11               6       1585.7710       261.6256      2.007870     2206.376
    #> 12               7       1585.7710       261.6256      1.900000     2206.376
    #> 13               3       1585.7710       497.0886      2.079058     2206.376
    #> 14               6       1794.4897       261.6256      2.106250     2206.376
    #> 15               7       1794.4897       261.6256      1.985556     2206.376
    #> 16               8       1794.4897       261.6256      1.900000     2206.376
    #> 17               4       1794.4897       497.0886      1.900000     2206.376
    #> 18               2       1794.4897       944.4683      1.900000     2206.376
    #> 19               7       2001.2815       261.6256      2.064214     2206.376
    #> 20               8       2001.2815       261.6256      1.970347     2206.376
    #> 21               9       2001.2815       261.6256      1.900000     2206.376
    #> 22               4       2001.2815       497.0886      2.006491     2206.376
    #> 23               3       2001.2815       723.5927      1.900000     2206.376
    #> 24               8       2206.3764       261.6256      2.035478     2206.376
    #> 25               9       2206.3764       261.6256      1.959387     2206.376
    #> 26              10       2206.3764       261.6256      1.900000     2206.376
    #> 27               4       2206.3764       497.0886      2.106798     2206.376
    #> 28               5       2206.3764       497.0886      1.900000     2206.376
    #> 29               3       2206.3764       723.5927      2.020631     2206.376
    #> 30               2       2206.3764      1161.2507      1.900000     2206.376

    #> [1] 1.9

    #> [[1]]
    #>    rational_number pseudo_rational_number pseudo_octave num den approximation
    #> 1         8.433336              10.000000           1.9  10   1     10.000000
    #> 2         4.438598               5.000000           1.9   5   1      5.000000
    #> 3         3.049197               3.333333           1.9  10   3      3.333333
    #> 4         2.336104               2.500000           1.9   5   2      2.500000
    #> 5         1.900000               2.000000           1.9   2   1      2.000000
    #> 6         1.604840               1.666667           1.9   5   3      1.666667
    #> 7         1.391359               1.428571           1.9   3   2      1.500000
    #> 8         1.229529               1.250000           1.9   5   4      1.250000
    #> 9         1.102482               1.111111           1.9   7   6      1.166667
    #> 10        1.000000               1.000000           1.9   1   1      1.000000
    #>    uncertainty
    #> 1      0.072
    #> 2      0.072
    #> 3      0.072
    #> 4      0.072
    #> 5      0.072
    #> 6      0.072
    #> 7      0.072
    #> 8      0.072
    #> 9      0.072
    #> 10     0.072

    #> [[1]]
    #>    rational_number pseudo_rational_number pseudo_octave num den approximation
    #> 1         1.000000                      1           1.9   1   1             1
    #> 2         1.900000                      2           1.9   2   1             2
    #> 3         2.765757                      3           1.9   3   1             3
    #> 4         3.610000                      4           1.9   4   1             4
    #> 5         4.438598                      5           1.9   5   1             5
    #> 6         5.254938                      6           1.9   6   1             6
    #> 7         6.061223                      7           1.9   7   1             7
    #> 8         6.859000                      8           1.9   8   1             8
    #> 9         7.649411                      9           1.9   9   1             9
    #> 10        8.433336                     10           1.9  10   1            10
    #>    uncertainty
    #> 1      0.072
    #> 2      0.072
    #> 3      0.072
    #> 4      0.072
    #> 5      0.072
    #> 6      0.072
    #> 7      0.072
    #> 8      0.072
    #> 9      0.072
    #> 10     0.072

``` r
P1$wavelengths[[1]]
#>  [1] 2206.3764 1161.2507  797.7478  611.1846  497.0886  419.8673  364.0150
#>  [8]  321.6761  288.4374  261.6256
```

    #>    harmonic_number evaluation_freq reference_freq pseudo_octave highest_freq
    #> 1                2       2206.3764      1161.2507      1.900000     2206.376
    #> 2                3       2206.3764       797.7478      1.900000     2206.376
    #> 3                4       2206.3764       611.1846      1.900000     2206.376
    #> 4                4       2206.3764       497.0886      2.106798     2206.376
    #> 5                5       2206.3764       497.0886      1.900000     2206.376
    #> 6                5       2206.3764       419.8673      2.043297     2206.376
    #> 7                6       2206.3764       419.8673      1.900000     2206.376
    #> 8                6       2206.3764       364.0150      2.007870     2206.376
    #> 9                7       2206.3764       364.0150      1.900000     2206.376
    #> 10               6       2206.3764       321.6761      2.106250     2206.376
    #> 11               7       2206.3764       321.6761      1.985556     2206.376
    #> 12               8       2206.3764       321.6761      1.900000     2206.376
    #> 13               7       2206.3764       288.4374      2.064214     2206.376
    #> 14               8       2206.3764       288.4374      1.970347     2206.376
    #> 15               9       2206.3764       288.4374      1.900000     2206.376
    #> 16               8       2206.3764       261.6256      2.035478     2206.376
    #> 17               9       2206.3764       261.6256      1.959387     2206.376
    #> 18              10       2206.3764       261.6256      1.900000     2206.376
    #> 19               2       1161.2507       611.1846      1.900000     2206.376
    #> 20               3       1161.2507       419.8673      1.900000     2206.376
    #> 21               3       1161.2507       364.0150      2.079058     2206.376
    #> 22               4       1161.2507       321.6761      1.900000     2206.376
    #> 23               4       1161.2507       288.4374      2.006491     2206.376
    #> 24               4       1161.2507       261.6256      2.106798     2206.376
    #> 25               5       1161.2507       261.6256      1.900000     2206.376
    #> 26               2        797.7478       419.8673      1.900000     2206.376
    #> 27               3        797.7478       288.4374      1.900000     2206.376
    #> 28               3        797.7478       261.6256      2.020631     2206.376
    #> 29               2        611.1846       321.6761      1.900000     2206.376
    #> 30               2        497.0886       261.6256      1.900000     2206.376

    #> [1] 1.9
