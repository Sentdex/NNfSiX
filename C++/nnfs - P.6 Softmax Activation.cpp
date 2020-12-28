/* This is a c++ implementation of neural networks from scratch in python  series. 
* In hope to do things in a similar way to the tutorial, I have created a numcpp library 
* containing stuff to help us with matrix and vector calculations. Knowing how this works is 
* not strictly necessary, you just need to be aware of what the functions do since the goal 
* here is to learn how neural networks work, so the parts you may be interested in are marked 
* as layer, activation and main (they are towards the end of the file). This implementation was 
* originally in seperate files, so you will see the sections marked as .h and cpp, but this file is
* completely standlone and compiles by itself.
*
*The part 6 bits i.e Softmax activation struct is decleared and defined after line 718 
*
* Link to the series on youtube: https://www.youtube.com/watch?v=Wo5dMEP_BbI&list=PLQVvvaa0QuDcjD5BAw2DxE6OF2tius3V3
* If you want to download the seperated files: https://github.com/HippozHipos/neural-net
*/

//===========================================================================================

//numcpp.h

#pragma once

#include "iostream"
#include <vector>
#include <random>

//Set debug to 0 to disable logging

#define DEBUG 1
#if DEBUG == 1
#define LOG(x) std::cout << x << std::endl
#else
#define LOG(x)
#endif

#define MAX(a, b) a > b ? a : b
#define MIN(a, b) a < b ? a : b

//#######################################
//#            CONSTANTS                #
//#######################################

#define EULERS_NUMBER pow((1.0 + 1.0 / 10000000.0), 10000000.0)
#define PI 3.14159265359

namespace numcpp {

	//#######################################
	//#                TYPES                #
	//#######################################

	// vector of doubles
	template<typename T>
	struct Vector
	{
		std::vector<T> v;

		//fill vector with num
		void fill(const unsigned int size, const T num)
		{
			v.clear();
			for (unsigned int i = 0; i < size; i++)
				v.push_back(num);
		}

		inline friend std::ostream& operator << (std::ostream& out, const Vector& vec)
		{
			out << "[";
			for (unsigned int j = 0; j < vec.v.size(); j++)
			{
				if (j % vec.v.size() == vec.v.size() - 1)
					out << vec.v[j] << "]" << std::endl;
				else
					out << vec.v[j] << ", ";
			}
			return out;
		}
	};

	typedef Vector<int> Vi;
	typedef Vector<float> Vf;
	typedef Vector<double> Vd;

	//row by column
	//matrix of vectors
	template<typename T>
	struct Matrix
	{
		std::vector<T> m;

		//fill matrix with num
		using numcpp_vector_type = typename decltype(std::declval<T>().v)::value_type;
		void fill(unsigned const int rows, unsigned const int cols, const numcpp_vector_type num)
		{
			m.clear();
			for (unsigned int i = 0; i < rows; i++)
			{

				T temp_vec;
				for (unsigned int j = 0; j < cols; j++)
				{
					temp_vec.v.push_back(num);
				}
				m.push_back(temp_vec);
			}
		}

		inline friend std::ostream& operator << (std::ostream& out, const Matrix& mat)
		{
			out << "[" << std::endl << std::endl;
			for (unsigned int i = 0; i < mat.m.size(); i++)
			{
				out << "[";
				for (unsigned int j = 0; j < mat.m[i].v.size(); j++)
				{
					if (j % mat.m[i].v.size() == mat.m[i].v.size() - 1)
						out << mat.m[i].v[j] << "]" << std::endl << std::endl;
					else
						out << mat.m[i].v[j] << ", ";
				}
			}
			out << "]" << std::endl;
			return out;
		}
	};

	typedef Matrix<Vi> Mi;
	typedef Matrix<Vf> Mf;
	typedef Matrix<Vd> Md;

	//#######################################
	//#               RANDOM                #
	//#######################################

	class Random
	{
	private:
		Random();
		~Random();
		Random(const Random&) = delete;
		std::mt19937 _random_engine;

	public:
		static Random& Get();
		int Range(const int lower, const int upper);
		double Range(const double lower, const double upper);
		void Matrix(const unsigned int rows, const unsigned int cols, const double lower, const double upper, Md& out_mat);
		void Vector(const unsigned int size, const double lower, const double upper, Vd& out_vec);
	};

	static Random& RNG = Random::Get();

	//#######################################
	//#   UTILITY FUNCTIONS FOR VECTOR      #
	//#######################################

	inline double vector_dot(const Vd& v1, const Vd& v2)
	{
		if (v1.v.size() != v2.v.size())
			throw std::exception();

		double total = 0.0;
		for (unsigned int i = 0; i < v1.v.size(); i++)
		{
			total += v1.v[i] * v2.v[i];
		}
		return total;
	}

	inline double vector_get_max(const Vd& vec)
	{
		double biggest = vec.v[0];
		for (unsigned int i = 1; i < vec.v.size(); i++)
		{
			biggest = MAX(biggest, vec.v[i]);
		}
		return biggest;
	}

	inline double vector_get_min(const Vd& vec)
	{
		double smallest = vec.v[0];
		for (unsigned int i = 1; i < vec.v.size(); i++)
		{
			smallest = MIN(smallest, vec.v[i]);
		}
		return smallest;
	}

	inline Vd vector_cap_max(const double value, const Vd& vec)
	{
		Vd out_vec;
		for (unsigned int i = 0; i < vec.v.size(); i++)
		{
			out_vec.v.push_back(MIN(value, vec.v[i]));
		}
		return out_vec;
	}

	inline Vd vector_cap_min(const double value, const Vd& vec)
	{
		Vd out_vec;
		for (unsigned int i = 0; i < vec.v.size(); i++)
		{
			out_vec.v.push_back(MAX(value, vec.v[i]));
		}
		return out_vec;
	}

	inline Vd vector_exp(const Vd& vec)
	{
		Vd out_vec;
		for (unsigned int i = 0; i < vec.v.size(); i++)
		{
			out_vec.v.push_back(pow(EULERS_NUMBER, vec.v[i]));
		}
		return out_vec;
	}

	inline double vector_sum(const Vd& vec)
	{
		double total = 0.0;
		for (unsigned int i = 0; i < vec.v.size(); i++)
			total += vec.v[i];
		return total;
	}

	inline Vd vector_normalize(const Vd& vec)
	{
		Vd out_vec;
		double total = vector_sum(vec);
		for (unsigned int i = 0; i < vec.v.size(); i++)
		{
			out_vec.v.push_back(vec.v[i] / total);
		}
		return out_vec;
	}

	inline double vector_mean(const Vd& vec)
	{
		double total = 0.0;
		for (unsigned int i = 0; i < vec.v.size(); i++)
			total += vec.v[i];
		return total / vec.v.size();
	}

	inline void vector_flip_sign(Vd& vec)
	{
		for (unsigned int i = 0; i < vec.v.size(); i++)
			vec.v[i] *= -1.0;
	}

	//#######################################
	//#   UTILITY FUNCTIONS FOR MATRIX      #
	//#######################################


	//Assumes that all the vectors in a matrix will have the same size. The only way 
	//for a vectors to have different sizes is if they are set manually, since all the
	//functions provided in this lib only produce rectangle shaped matrices, i.e all 
	//vectors in the matrix are the same size
	inline void matrix_dot(const Md& m1, const Md& m2, Md& outm)
	{
		if (m1.m[0].v.size() && m2.m.size())
			if (m1.m[0].v.size() != m2.m.size())
			{
				LOG("Shape mismatch: " << "matrix1 columns: " << m1.m[0].v.size() << ", " << "matrix2 rows: " << m2.m.size());
				throw std::exception();
			}

		unsigned int m1x = 0; unsigned int m1y = 0; unsigned int m2y = 0; //m2y = m1x

		while (outm.m.size() < m1.m.size())
		{
			Vd temp_vec;
			while (temp_vec.v.size() < m2.m[0].v.size())
			{
				double total = 0.0;
				while (m1x < m1.m[0].v.size())
				{
					total += m1.m[m1y].v[m1x] * m2.m[m1x].v[m2y];
					m1x++;
				}
				temp_vec.v.push_back(total);
				m1x = 0;
				m2y < m2.m[0].v.size() - 1 ? m2y++ : m2y = 0;
			}
			m1y < m1.m.size() - 1 ? m1y++ : m1y = 0;
			outm.m.push_back(temp_vec);
		}
	}

	//assumes that all the vectors in the matrix will be the same size
	inline void matrix_add(Md& mat, const Vd& vec)
	{
		if (mat.m[0].v.size() != vec.v.size())
		{
			LOG("Shape mismatch: " << "matrix columns: " << mat.m[0].v.size() << ", " << "vector size: " << vec.v.size());
			throw std::exception();
		}

		for (unsigned int i = 0; i < mat.m.size(); i++)
			for (unsigned int j = 0; j < vec.v.size(); j++)
			{
				mat.m[i].v[j] += vec.v[j];
			}

	}

	//value less than lower, than lower otherwise value (cap values at lower)
	//used for rectified linear activation function in hidden layer
	inline Md matrix_cap_min(const double value, const Md& inmat)
	{
		Md out_mat;
		for (unsigned int i = 0; i < inmat.m.size(); i++)
		{
			Vd temp_vec;
			for (unsigned int j = 0; j < inmat.m[i].v.size(); j++)
			{
				temp_vec.v.push_back(MAX(value, inmat.m[i].v[j]));
			}
			out_mat.m.push_back(temp_vec);
		}
		return out_mat;
	}

	//caps max value in matrix at value
	inline Md matrix_cap_max(const double value, const Md& inmat)
	{
		Md out_mat;
		for (unsigned int i = 0; i < inmat.m.size(); i++)
		{
			Vd temp_vec;
			for (unsigned int j = 0; j < inmat.m[i].v.size(); j++)
			{
				temp_vec.v.push_back(MIN(value, inmat.m[i].v[j]));
			}
			out_mat.m.push_back(temp_vec);
		}
		return out_mat;
	}

	//axis = 0 means max value in each row
	//axis = 1 means max value in each column
	inline Vd matrix_max_in_axis(const Md& mat, const int axis)
	{
		Vd out_vec;

		if (axis == 0)
		{
			for (unsigned int i = 0; i < mat.m[0].v.size(); i++)
			{
				out_vec.v.push_back(mat.m[0].v[i]);
				for (unsigned int j = 1; j < mat.m.size(); j++)
				{
					out_vec.v[i] = MAX(mat.m[j].v[i], out_vec.v[i]);
				}
			}
		}
		else if (axis == 1)
		{
			for (unsigned int i = 0; i < mat.m.size(); i++)
			{
				out_vec.v.push_back(mat.m[i].v[0]);
				for (unsigned int j = 1; j < mat.m[i].v.size(); j++)
				{
					out_vec.v[i] = MAX(mat.m[i].v[j], out_vec.v[i]);
				}
			}
		}
		else
		{
			LOG("axis must be either 0 or 1. Provided was: " << axis);
			throw std::exception();
		}

		return out_vec;
	}

	//returns biggest value from whole of the matrix
	inline double matrix_max(const Md& mat)
	{
		double biggest = mat.m[0].v[0];
		for (unsigned int i = 0; i < mat.m.size(); i++)
			for (unsigned int j = 0; j < mat.m[i].v.size(); j++)
			{
				biggest = MAX(mat.m[i].v[j], biggest);
			}
		return biggest;
	}

	//exponentiate all the elements
	inline Md matrix_exp(const Md& mat)
	{
		Md out_mat;
		for (unsigned int i = 0; i < mat.m.size(); i++)
		{
			Vd temp_vec;
			for (unsigned int j = 0; j < mat.m[i].v.size(); j++)
			{
				temp_vec.v.push_back(pow(EULERS_NUMBER, mat.m[i].v[j]));
			}
			out_mat.m.push_back(temp_vec);
		}
		return out_mat;
	}

	//minus value from all the elements
	inline Md matrix_minus(const double value, const Md& mat)
	{
		Md out_mat;
		for (unsigned int i = 0; i < mat.m.size(); i++)
		{
			Vd temp_vec;
			for (unsigned int j = 0; j < mat.m[i].v.size(); j++)
			{
				temp_vec.v.push_back(mat.m[i].v[j] - value);
			}
			out_mat.m.push_back(temp_vec);
		}
		return out_mat;
	}


	// 0 = rows, 1 = columns
	inline Md matrix_minus_in_axis(const Md& mat, const int axis)
	{
		Md out_mat;
		if (axis == 0)
		{
			out_mat = mat;
			Vd max = matrix_max_in_axis(mat, 0);
			for (unsigned int i = 0; i < mat.m[0].v.size(); i++)
				for (unsigned int j = 0; j < mat.m.size(); j++)
				{
					out_mat.m[j].v[i] = mat.m[j].v[i] - max.v[i];
				}
		}
		else if (axis == 1)
		{
			Vd max = matrix_max_in_axis(mat, 1);
			for (unsigned int i = 0; i < mat.m.size(); i++)
			{
				Vd temp_vec;
				for (unsigned int j = 0; j < mat.m[i].v.size(); j++)
				{
					temp_vec.v.push_back(mat.m[i].v[j] - max.v[i]);
				}
				out_mat.m.push_back(temp_vec);
			}
		}
		else
		{
			LOG("axis must be either 0 or 1. Provided was: " << axis);
			throw std::exception();
		}
		return out_mat;
	}

	//axis 0 means rows are summed 
	//axis 1 means that columns 
	inline Vd matrix_sum_in_axis(const Md& mat, const int axis)
	{
		Vd out_vec;

		if (axis == 0)
		{
			for (unsigned int i = 0; i < mat.m[0].v.size(); i++)
			{
				double _total = 0.0;
				for (unsigned int j = 0; j < mat.m.size(); j++)
				{
					_total += mat.m[j].v[i];
				}
				out_vec.v.push_back(_total);
			}
		}
		else if (axis == 1)
		{
			for (unsigned int i = 0; i < mat.m.size(); i++)
			{
				out_vec.v.push_back(vector_sum(mat.m[i]));
			}
		}
		else
		{
			LOG("axis must be either 0 or 1. Provided was: " << axis);
			throw std::exception();
		}
		return out_vec;
	}

	/*axis 0 means rows are summed to normalize
	axis 1 means that columns are summed to normalize*/
	inline Md matrix_normalize_in_axis(const Md& mat, int axis)
	{
		Md out_mat;
		if (axis == 0)
		{
			Vd _temp_vec = matrix_sum_in_axis(mat, 0);
			Vd temp_vec;
			for (unsigned int i = 0; i < mat.m.size(); i++)
			{
				for (unsigned int j = 0; j < mat.m[i].v.size(); j++)
				{
					if (_temp_vec.v[j] != 0)
						temp_vec.v.push_back(mat.m[i].v[j] / _temp_vec.v[j]);
					else
						temp_vec.v.push_back(1.0 / mat.m.size());
				}
				out_mat.m.push_back(temp_vec);
			}
		}
		else if (axis == 1)
		{
			for (unsigned int i = 0; i < mat.m.size(); i++)
			{
				Vd temp_vec;
				double total = vector_sum(mat.m[i]);
				for (unsigned int j = 0; j < mat.m[i].v.size(); j++)
				{
					if (total != 0)
						temp_vec.v.push_back(mat.m[i].v[j] / total);
					else
						temp_vec.v.push_back(1.0 / mat.m[i].v.size());
				}
				out_mat.m.push_back(temp_vec);
			}
		}
		else
		{
			LOG("axis must be either 0 or 1. Provided was: " << axis);
			throw std::exception();
		}
		return out_mat;
	}

	// 0 = rows, 1 = columns
	inline Vd matrix_mean_in_axis(const Md& mat, const int axis)
	{
		Vd out_vec;
		if (axis == 0)
		{
			for (unsigned int i = 0; i < mat.m[0].v.size(); i++)
			{
				double _total = 0.0;
				for (unsigned int j = 0; j < mat.m.size(); j++)
				{
					_total += mat.m[j].v[i];
				}
				out_vec.v.push_back(_total / mat.m.size());
			}
		}
		else if (axis == 1)
		{
			for (unsigned int i = 0; i < mat.m.size(); i++)
				out_vec.v.push_back(vector_mean(mat.m[i]));
		}
		else
		{
			LOG("axis must be either 0 or 1. Provided was: " << axis);
			throw std::exception();
		}
		return out_vec;
	}

	inline Md matrix_log(const Md& mat)
	{
		Md out_mat;
		for (unsigned int i = 0; i < mat.m.size(); i++)
		{
			Vd temp_vec;
			for (unsigned int j = 0; j < mat.m[i].v.size(); j++)
			{
				temp_vec.v.push_back(log(mat.m[i].v[j]));
			}
			out_mat.m.push_back(temp_vec);
		}
		return out_mat;
	}

	inline void matrix_flip_sign(Md& mat)
	{
		for (unsigned int i = 0; i < mat.m.size(); i++)
			vector_flip_sign(mat.m[i]);
	}

	//takes a vector of indices and returns a vector of elements
	//at those indices along the matrix. 
	inline Vd matrix_item_at_index(const Md& mat, const int indices[])
	{
		Vd temp_vec;
		for (unsigned int i = 0; i < mat.m.size(); i++)
			temp_vec.v.push_back(mat.m[i].v[indices[i]]);
		return temp_vec;
	}
}


//===============================================================================================

//numcpp.cpp
//contains implementations for the random class in numcpp.h

namespace numcpp {

	//#######################################
	//#               RANDOM                #
	//#######################################


	// To make generate the same set of random numbers (for debugging)
	//comment out: std::mt19937 random_engine(random_seed());
	//uncomment: std::mt19937 random_engine(3);
	Random::Random()
	{
		std::random_device random_seed;
		std::mt19937 random_engine(3);
		//std::mt19937 random_engine(random_seed());
		_random_engine = random_engine;
	};

	Random::~Random() {};


	Random& Random::Get()
	{
		static Random random;
		return random;
	}

	int Random::Range(const int lower, const int upper)
	{
		std::uniform_int_distribution<int> distribution(lower, upper);
		return distribution(_random_engine);
	}

	double Random::Range(const double lower, const double upper)
	{
		std::uniform_real_distribution<double> distribution(lower, upper);
		return distribution(_random_engine);
	}

	void Random::Matrix(const unsigned int rows, const unsigned int cols, const double lower, const double upper, Md& out_mat)
	{
		for (unsigned int i = 0; i < rows; i++)
		{
			Vd temp_vec;
			for (unsigned int j = 0; j < cols; j++)
			{
				temp_vec.v.push_back(Range(lower, upper));
			}
			out_mat.m.push_back(temp_vec);
		}
	}

	void Random::Vector(const unsigned int size, const double lower, const double upper, Vd& out_vec)
	{
		for (unsigned int i = 0; i < size; i++)
			out_vec.v.push_back(Range(lower, upper));
	}
}

//==============================================================================================

//layer.h
namespace neural_net {

	struct LayerDense
	{
		numcpp::Md weights;
		numcpp::Md output;
		numcpp::Vd biases;
		LayerDense(const int nInputs, const int nNeurons, double bias = 0.0);
		~LayerDense();
		void Forward(const numcpp::Md& inputs);
	};

}

//================================================================================================

//layer.cpp

namespace neural_net {

	LayerDense::LayerDense(const int nInputs, const int nNeurons, double bias)
	{
		numcpp::RNG.Matrix(nInputs, nNeurons, 0.0, 1.0, weights);
		LOG("(dense layer init) initialized with matrix: " << std::endl << weights);
		biases.fill(nNeurons, bias);
		LOG("(dense layer init) Filled Biases vector with a bias value of: " << bias << std::endl);
	}

	LayerDense::~LayerDense() {};

	void LayerDense::Forward(const numcpp::Md& inputs)
	{
		numcpp::matrix_dot(inputs, weights, output);
		LOG(" (dense layer forward) inputs * weights in forward method of dense layer. output: " << std::endl << output);
		numcpp::matrix_add(output, biases);
		LOG("(dense layer forward) biases added to output matrix from dot product of weights and input: " << std::endl << output);
	}

}

//==========================================================================================

//activation.h

namespace neural_net {

	struct ActivationReLU
	{
		numcpp::Md output;
		ActivationReLU();
		~ActivationReLU();
		void Forward(const numcpp::Md& input);
	};

	struct ActivationSoftmax
	{
		numcpp::Md output;
		ActivationSoftmax();
		void Forward(const numcpp::Md& input);
	};

}
//===========================================================================

//activation.cpp

namespace neural_net {

	ActivationReLU::ActivationReLU() {};

	ActivationReLU::~ActivationReLU() {};

	void ActivationReLU::Forward(const numcpp::Md& input)
	{
		output = numcpp::matrix_cap_min(0.0, input);
		LOG("(ReLU forward) forward pass. matrix capped at min value of 0. output: " << std::endl << output);
	}


	ActivationSoftmax::ActivationSoftmax() {};

	void ActivationSoftmax::Forward(const numcpp::Md& input)
	{
		numcpp::Md negated = numcpp::matrix_minus_in_axis(input, 1);
		LOG("(softmax forward) input matrix's highest value negated from all the elements in matrix. output: " << std::endl << negated);
		numcpp::Md exp = numcpp::matrix_exp(negated);
		LOG("(softmax forward) all the elements in the negated matrix exponentiated. output: " << std::endl << exp);
		output = numcpp::matrix_normalize_in_axis(exp, 1);
		LOG("(softmax forward) exponentiated matrix is normalized. output: " << std::endl << output);
	}

}

//=======================================================================================

//main.cpp

//NOTES:
//1. matrices are ordered row by column 
//2. LOG macro in numcpp.h file is responsible for logging. Set DEBUG macro to 0 to turn logging off.

int main()
{
	//output up to 10 digits
	std::cout.precision(10);

	//create a matrix 
	numcpp::Md X;

	//all the matrices size will be 3x3 to make it easier to test things.
	const int nMatSize = 3;

	//fill X will random numbers between -1.0 and 1.0. This is the actual input.  
	numcpp::RNG.Matrix(nMatSize, nMatSize, -1.0, 1.0, X);

	//initilaize dense layer1 of size nMatSize x nMatSize
	neural_net::LayerDense layer1 = neural_net::LayerDense(nMatSize, nMatSize);
	//ReLU object for layer 1
	neural_net::ActivationReLU ReLU1;

	//forward pass of layer 1.
	layer1.Forward(X);
	//output of layer 1 is passed to ReLU as input.
	ReLU1.Forward(layer1.output);

	//initilaize dense layer2 of size nMatSize x nMatSize. This is an output layer.
	neural_net::LayerDense layerOut = neural_net::LayerDense(nMatSize, nMatSize);
	//it uses softmax activation function since its an output layer
	neural_net::ActivationSoftmax softmax;

	//output of ReLU1 is passed to the output layer as input.
	layerOut.Forward(ReLU1.output);
	//output of output layer is passed through the softmax activation function.
	softmax.Forward(layerOut.output);
}
