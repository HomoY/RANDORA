# based on ZnCdHgSSeTe Stillinger-Weber potential, X. W. Zhou, D. K. Ward, J. E. Martin, F. B. van Swol, J. L. Cruz-Campa, and D. Zubia, Phys. Rev. B, 88, 085309 (2013).
# modified by hydro
# Note that the way the parameters can be entered is not unique. As one way, we assume that eps_ijk is equal to eps_ik and lambda_ijk is equal to
# sqrt(lambda_ij*eps_ij*lambda_ik*eps_ik)/eps_ik, and all other parameters in the ijk line are for ik.
#  
# These entries are in LAMMPS "metal" units: epsilon = eV; sigma = Angstroms; other quantities are unitless;
#
# cutoff distance = 4.632
#               eps          sigma            a            lambda          gamma       cos(theta)         A              B              p              q             tol
Se Se Se   2.400781e+00   2.789002e+00   1.544925e+00   3.250000e+01   1.200000e+00  -3.333333e-01   7.917000e+00   7.672131e-01   4.000000e+00   0.000000e+00   0.000000e+00
Se Se Cd   1.352371e+00   2.045165e+00   1.953387e+00   4.330238e+01   1.200000e+00  -3.333333e-01   7.049600e+00   1.116149e+00   4.000000e+00   0.000000e+00   0.000000e+00
Se Cd Se   2.400781e+00   2.789002e+00   1.544925e+00   2.439242e+01   1.200000e+00  -3.333333e-01   7.917000e+00   7.672131e-01   4.000000e+00   0.000000e+00   0.000000e+00
Se Cd Cd   1.352371e+00   2.045165e+00   1.953387e+00   3.250000e+01   1.200000e+00  -3.333333e-01   7.049600e+00   1.116149e+00   4.000000e+00   0.000000e+00   0.000000e+00
Cd Se Se   1.352371e+00   2.045165e+00   1.953387e+00   3.250000e+01   1.200000e+00  -3.333333e-01   7.049600e+00   1.116149e+00   4.000000e+00   0.000000e+00   0.000000e+00
Cd Se Cd   1.182358e+00   2.663951e+00   1.527956e+00   3.475816e+01   1.200000e+00  -3.333333e-01   7.917000e+00   7.674460e-01   4.000000e+00   0.000000e+00   0.000000e+00
Cd Cd Se   1.352371e+00   2.045165e+00   1.953387e+00   3.038855e+01   1.200000e+00  -3.333333e-01   7.049600e+00   1.116149e+00   4.000000e+00   0.000000e+00   0.000000e+00
Cd Cd Cd   1.182358e+00   2.663951e+00   1.527956e+00   3.250000e+01   1.200000e+00  -3.333333e-01   7.917000e+00   7.674460e-01   4.000000e+00   0.000000e+00   0.000000e+00
