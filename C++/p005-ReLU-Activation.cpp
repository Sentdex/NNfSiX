

/**
 * Creates a basic neuron with 3 inputs
 *
 * Associated YT NNFS tutorial: https://youtu.be/gmjzbpSVY1A
 */
 
 
#include <vector>
#include <random>
#include <numeric>
#include <iostream>
#include <algorithm>
#include <cmath>
#include <iomanip>
#include <tuple>

using dmatrix   = std::vector< std::vector< double> > ; // dmatrix stands for dynamic matrix
using drow      = std::vector< double > ;    // drow stands for dynamic row

double random(const double& min, const double& max){
    std::mt19937_64 rng{}; rng.seed( std::random_device{}());
    return std::uniform_real_distribution<>{min, max}(rng);
}

// matrix transpose function
dmatrix T(const dmatrix& m) noexcept {
    dmatrix mat;
    for(size_t i=0; i<m[0].size(); i++){
        mat.push_back({});
        for(size_t j=0; j<m.size(); j++){
            mat[i].push_back(m[j][i]);
        }
    }return mat;
}

dmatrix operator*(const dmatrix& m1, const dmatrix& m2) {
    dmatrix m3 = T(m2);
    dmatrix rval;
    for(size_t i=0; i<m1.size(); i++){
        rval.push_back({});
        for(size_t j=0; j<m3.size(); j++){
            rval[i].push_back(std::inner_product(m1[i].begin(), m1[i].end(), m3[j].begin(), 0.0));
        }
    }return rval;
}
 
// matrix vector addition operator
dmatrix operator+(const dmatrix& m, const drow& row) {
    dmatrix     xm;
    for(size_t j=0; j<m.size(); j++){
        xm.push_back({});
        for(size_t i=0; i< m[j].size(); i++){
            xm[j].push_back( m[j][i] + row[j]);
        }
    }return xm;
}

drow operator+(const drow& r1, const drow& r2){
    drow rval(r1.begin(), r1.end());
    for(size_t i=0; i<rval.size(); i++)
        rval[i] += r2[i];
    return rval;
}

std::ostream& operator<<(std::ostream& os, const  drow& dr){
    os << " [";
    for(auto& item : dr)
        os << std::setw(15) << item << " ";
    os << "]\n";
    return os;
}

// ostream << operator for matrix
std::ostream& operator<<(std::ostream& os,const  dmatrix& dm) {
    std::cout << "[\n";
    for(auto& row : dm){
        os << row;
    } std::cout << " ]";
    return os;
}


struct activation_relu {
    dmatrix operator()(const dmatrix& inputs){
        dmatrix output(inputs.size(), drow(inputs[0].size(), 0));
        for(size_t i=0; i<inputs.size(); i++)
            for(size_t j=0; j<inputs[i].size(); j++)
                output[i][j] = std::max(0.0, inputs[i][j]);
        return output; 
    }
}; 


// Dense Layer class 
class dense_layer {
    private:
        dmatrix     m_weights, m_output;
        drow        m_biases;

    public:
        // constructor 
        dense_layer( const size_t& n_input, const size_t& n_neuron) 
            : m_weights(n_input, drow(n_neuron)),
            m_biases(n_neuron, 0)
        {
            for(size_t j=0; j<n_neuron; j++){
                for(size_t i=0; i<n_input; i++)
                    m_weights[i][j] = ( random(-1.0, 1.0) );
            }
        }
        // forward pass
        void forward( const dmatrix& inputs){
            m_output = inputs * m_weights + m_biases;
        }

        dmatrix output() const {
            return m_output;
        }
};


std::tuple<dmatrix, drow> spiral_data(const size_t& points, const size_t& classes){
    dmatrix X(points*classes, drow(2,0));
    drow y(points*classes, 0);
    double r, t;
    for(size_t i=0; i<classes; i++){
        for(size_t j=0; j<points; j++){
            r = double(j)/double(points);
            t = i*4 + (4*r);
            X[i*points+j] = drow{r*cos(t*2.5), r*sin(t*2.5)} + drow{ random(-0.15,0.15), random(-0.15,0.15) };
            y[i*points+j] = i;
        }
    }
    return std::make_tuple(X,y);
}

int main(){

    auto [X,y] = spiral_data(100,3);
    dense_layer l1(2, 5);
    activation_relu activation_1;

    l1.forward(X);
    std::cout << l1.output() << "\n";
    auto activation_output = activation_1(l1.output());
    std::cout << " \n\n " << activation_output;
    
}

