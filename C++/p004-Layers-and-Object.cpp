/**
 * Creates a dense layer 
 * 
 * Associated tutorial https://www.youtube.com/watch?v=TEWy9vZcxW4
 */

#include <vector>
#include <numeric>
#include <iostream>
#include <ctime>
#include <random>

using dmatrix   = std::vector< std::vector< double> > ; // dmatrix stands for dynamic matrix
using drow      = std::vector< double > ;    // drow stands for dynamic row

double random(const double& min, const double& max){
    std::mt19937_64 rng{}; rng.seed( std::random_device{}());
    return std::uniform_real_distribution<>{min, max}(rng);
}
// Transpose matrix
dmatrix T(const dmatrix& m) noexcept {
    dmatrix mat;
    for(size_t i=0; i<m[0].size(); i++){
        mat.push_back({});
        for(size_t j=0; j<m.size(); j++){
            mat[i].push_back(m[j][i]);
        }
    }return mat;
}
// matrix multiplication
dmatrix operator*(const dmatrix& m1, const dmatrix& m2) noexcept {
    dmatrix m3 = T(m2);
    dmatrix rval;
    for(size_t i=0; i<m1.size(); i++){
        rval.push_back({});
        for(size_t j=0; j<m3.size(); j++){
            rval[i].push_back(std::inner_product(m1[i].begin(), m1[i].end(), m3[j].begin(), 0.0));
        }
    }return rval;
}
// matrix vector addition
dmatrix operator+(const dmatrix& m, const drow& row) noexcept {
    dmatrix     xm;
    for(size_t j=0; j<m.size(); j++){
        xm.push_back({});
        for(size_t i=0; i< m[j].size(); i++){
            xm[j].push_back( m[j][i] + row[j]);
        }
    }return xm;
}

std::ostream& operator<<(std::ostream& os,const dmatrix& dm) noexcept {
    for(auto& row : dm){
        for(auto& item : row)
            os << item << " ";
        os << "\n";
    }return os;
}

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

int main(){
    dense_layer l1(4,5);
    dense_layer l2(5,4);

    dmatrix X{
        drow{1, 2, 3, 2.5},
     	drow{2.0, 5.0, -1.0, 2.0},
     	drow{-1.5, 2.7, 3.3, -0.8}
    };
    
    l1.forward(X);
    std::cout << "\n\n"<< l1.output();
    
    l2.forward(l1.output());
    std::cout << "\n" <<l2.output();   
}
