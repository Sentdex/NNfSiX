/**
 * A header file for various dataset creation functions
 * 
 * Associated tutorial https://www.youtube.com/watch?v=gmjzbpSVY1A&t=1349s
 */

#include <random>
#include <vector>
#include <cmath>
using namespace std;

pair<vector<vector<double>>, vector<double>> spiral_data(int points, int classes) {
	// for random number generation
	random_device rd;  
	mt19937 gen(rd()); 
	uniform_real_distribution<> dis(-1, 1);

	// The data that will be generated
	vector<vector<double>> X(points * classes, vector<double>(2, 0));
	vector<double> y(points * classes, 0);

	// A variable to keep track of the index of X and y
	int ix = 0;
	for(int class_number = 0; class_number < classes; class_number++) {
		double r = 0;
		double t = class_number * 4;

		while(r <= 1 && t <= (class_number + 1) * 4) {
			// adding some randomness to t
			double random_t = t + dis(gen) * 0.2;

			// converting from polar to cartesian coordinates
			X[ix][0] = r * sin(random_t * 2.5);
			X[ix][1] = r * cos(random_t * 2.5);
			y[ix] = class_number;


			// the below two statements achieve linspace-like functionality
			r += 1.0f / (points - 1); 
			t += 4.0f / (points - 1);

			ix++; // increment index
		}
	}

	return make_pair(X, y);
}