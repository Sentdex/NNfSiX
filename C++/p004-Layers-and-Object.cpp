/**
 * Creates a dense layer
 *
 * Associated tutorial https://www.youtube.com/watch?v=TEWy9vZcxW4
 */
#include <algorithm>
#include <array>
#include <chrono>
#include <initializer_list>
#include <iostream>
#include <iterator>
#include <random>
#include <type_traits>

/// Types
template <std::size_t size> struct SizeType {
	static constexpr std::size_t get() { return size; }
};

template <class T, std::size_t s> struct List {
	static constexpr SizeType<s> width;
	static constexpr SizeType<1> height;
	static constexpr SizeType<s> size;
	std::array<T, s> list;
	constexpr inline auto begin() noexcept { return list.begin(); };
	constexpr inline auto end() noexcept { return list.end(); };
	constexpr inline auto begin() const noexcept { return list.cbegin(); };
	constexpr inline auto end() const noexcept { return list.cend(); };
	typedef T value_type;
};

#define IS_LIST(L)                                                             \
	std::enable_if_t<std::is_same_v<typename L::value_type, double>,       \
			 bool> = true

template <std::size_t w, std::size_t h> struct Matrix {
	static constexpr SizeType<w> width;
	static constexpr SizeType<h> height;
	static constexpr SizeType<h> size;
	List<List<double, w>, h> matrix;
	constexpr inline auto begin() noexcept { return matrix.begin(); };
	constexpr inline auto end() noexcept { return matrix.end(); };
	constexpr inline auto begin() const noexcept { return matrix.begin(); };
	constexpr inline auto end() const noexcept { return matrix.end(); };
	typedef typename decltype(matrix)::value_type value_type;
};

#define IS_MATRIX(M)                                                           \
	std::enable_if_t<!std::is_same_v<typename M::value_type, double>,      \
			 bool> = true

template <class M, IS_MATRIX(M)> auto pretty_print(const M &matrix) {
	std::for_each(std::begin(matrix), std::end(matrix),
		      [](const auto &list) { pretty_print(list); });
}

template <class L, IS_LIST(L)> auto pretty_print(const L &list) {
	std::cout << "[ ";
	std::copy(std::begin(list), std::end(list),
		  std::ostream_iterator<double>(std::cout, " "));
	std::cout << "]\n";
}

// python zip built-in
template <class M, class N> auto zip(const M &m, const N &n) {
	constexpr auto m_s = decltype(m.size)::get();
	constexpr auto n_s = decltype(n.size)::get();
	constexpr auto size = std::min(m_s, n_s);
	List<std::tuple<typename M::value_type, typename N::value_type>, size>
	    zipped;
	for (auto [it, mIt, nIt] =
		 std::tuple{std::begin(zipped), std::begin(m), std::begin(n)};
	     (mIt != std::end(m) && nIt != std::end(n)); ++mIt, ++nIt, ++it) {
		*it = {*mIt, *nIt};
	}
	return zipped;
}

// numpy randn
template <class L, IS_LIST(L)> auto randn(L &list, double factor) {
	std::mt19937 generator(/* Arbitrary Seed */ 0);
	std::generate(std::begin(list), std::end(list), [&]() {
		return static_cast<double>(generator()) /
		       static_cast<double>(generator.max()) * factor;
	});
}

// numpy randn
template <class M, IS_MATRIX(M)> auto randn(M &matrix, double factor) {
	std::for_each(std::begin(matrix), std::end(matrix),
		      [&](auto &list) { randn(list, factor); });
}

// numpy zeros
template <class L, IS_LIST(L)> auto zeros(L &list) {
	std::fill(std::begin(list), std::end(list), 0);
}

template <class M, IS_MATRIX(M)> auto zeros(M &matrix) {
	std::for_each(std::begin(matrix), std::end(matrix), [](auto &list) {
		std::fill(std::begin(list), std::end(list), 0);
	});
}

// numpy dot product
template <class M, class N, class O>
auto dot(M &inputs, N &weights, O &biases) {
	constexpr auto width = decltype(weights.height)::get();
	constexpr auto height = decltype(inputs.height)::get();

	constexpr auto inputs_w = decltype(inputs.width)::get();
	constexpr auto inputs_h = decltype(inputs.height)::get();
	constexpr auto weights_w = decltype(weights.width)::get();
	constexpr auto weights_h = decltype(weights.height)::get();

	constexpr auto biases_w = decltype(biases.width)::get();

	static_assert(inputs_w == weights_w, "Inputs.w != Weights.w");
	static_assert(biases_w == weights_h, "Biases.w != Weights.h");
	Matrix<width, height> outputs;
	zeros(outputs);

	auto zipped_weights_and_biases = zip(weights, biases);
	std::transform(
	    std::begin(inputs), std::end(inputs), std::begin(outputs),
	    [width, &zipped_weights_and_biases](const auto &input) {
		    List<double, width> outputLine;
		    std::transform(
			std::begin(zipped_weights_and_biases),
			std::end(zipped_weights_and_biases),
			std::begin(outputLine),
			[&input, &zipped_weights_and_biases](
			    const auto &zipped_weights_and_biasesLine) {
				/* std::cout << "Weights Line ";
				 * pretty_print(weightsLine); */
				/* std::cout << "Input : ";pretty_print(input);
				 */
				double result =
				    std::inner_product(
					std::begin(input), std::end(input),
					std::begin(std::get<0>(
					    zipped_weights_and_biasesLine)),
					0.0f) +
				    std::get<1>(zipped_weights_and_biasesLine);
				return result;
			});
		    return outputLine;
	    });
	return outputs;
}

template <std::size_t inputs_width, std::size_t inputs_height,
	  std::size_t n_neurons>
class DenseLayer {
      public:
	DenseLayer() {
		randn(weights, 0.10);
		zeros(biases);
		std::cout << "Biases : \n";
		pretty_print(biases);
	}

	template <class M, IS_MATRIX(M)> auto forward(const M &inputs) {
		outputs = dot(inputs, weights, biases);
	}
	Matrix<n_neurons, inputs_height> outputs;

      private:
	Matrix<inputs_width, n_neurons> weights;
	List<double, n_neurons> biases;
};

int main() {
	Matrix<4, 3> X{std::array{1.0, 2.0, 3.0, 2.5},
		       std::array{2.0, 5.0, -1.0, 2.0},
		       std::array{-1.5, 2.7, 3.3, -0.8}};

	DenseLayer<4, decltype(X)::height.get(), 5> denseLayer1;
	DenseLayer<5, decltype(denseLayer1.outputs)::height.get(), 2>
	    denseLayer2;

	std::cout << "Inputs : \n";
	pretty_print(X);
	denseLayer1.forward(X);
	std::cout << "Outputs : \n";
	pretty_print(denseLayer1.outputs);

	std::cout << "Inputs : \n";
	pretty_print(denseLayer1.outputs);
	denseLayer2.forward(denseLayer1.outputs);
	std::cout << "Outputs : \n";
	pretty_print(denseLayer2.outputs);

	return 0;
}
