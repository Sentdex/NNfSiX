package NNfSiX.Java;

import java.util.Random;

/**
 * Utils for matrix and vector manipulation in JAVA. Associated tutorial
 * https://www.youtube.com/watch?v=lGLto9Xd7bU
 */
public class Utils {
    public static Random random = new Random();
    static {
        random.setSeed(0);
    }

    /**
     * Multiplies two matrix.
     */
    public static double[][] dotProduct(double[][] matrix1, double[][] matrix2) {
        if (matrix1[0].length != matrix2.length)
            throw new RuntimeException(
                    matrix1.length + "x" + matrix1[0].length + " " + matrix2.length + "x" + matrix2[0].length);
        double[][] result = new double[matrix1.length][matrix2[0].length];
        for (int i = 0; i < matrix1.length; i++) {
            for (int j = 0; j < matrix2[0].length; j++) {
                for (int k = 0; k < matrix1[0].length; k++)
                    result[i][j] += matrix1[i][k] * matrix2[k][j];
            }
        }
        return result;
    }

    /**
     * Prints matrix to System.out.
     */
    public static void print2dArr(double[][] arr) {
        for (int i = 0; i < arr.length; i++) {
            for (int j = 0; j < arr[i].length; j++) {
                System.out.printf("%.2f ", arr[i][j]);
            }
            System.out.println();
        }
    }

    /**
     * Adds scalar bias to matrix
     */
    public static double[][] add(double[][] matrix, double bais) {
        double[][] result = new double[matrix.length][matrix[0].length];
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < matrix[i].length; j++) {
                result[i][j] = matrix[i][j] + bais;
            }
        }
        return result;
    }

    /**
     * Addeds Vector and Matrix;
     */
    public static double[][] add(double[][] matrix, double[] vector) {
        if (matrix[0].length != vector.length)
            throw new RuntimeException(matrix.length + "x" + matrix[0].length + " 1x" + vector.length);
        double[][] result = new double[matrix.length][vector.length];
        for (int i = 0; i < matrix.length; i++) {
            for (int j = 0; j < vector.length; j++) {
                result[i][j] = matrix[i][j] + vector[j];
            }
        }
        return result;
    }

    /**
     * Product of matrix and vector
     */
    public static double[][] dotProduct(double[][] matrix1, double[] matrix2) {
        if (matrix1[0].length != matrix2.length)
            throw new RuntimeException(matrix1.length + "x" + matrix1[0].length + " " + matrix2.length + "x1");
        double[][] result = new double[1][matrix1.length];
        for (int i = 0; i < matrix1.length; i++) {
            for (int j = 0; j < 1; j++) {
                for (int k = 0; k < matrix1[0].length; k++)
                    result[j][i] += matrix1[i][k] * matrix2[k];
            }
        }
        return result;
    }

    /**
     * Transposes a matrix
     */
    public static double[][] transpose(double[][] matrix) {
        double[][] result = new double[matrix[0].length][matrix.length];
        for (int i = 0; i < matrix.length; i++)
            for (int j = 0; j < matrix[i].length; j++)
                result[j][i] = matrix[i][j];
        return result;
    }

    /**
     * Creates a random matrix of given shape and multiplies every element with `m`
     * to make matrix radom to between a range.
     */
    public static double[][] random(int x, int y, double m) {
        double[][] result = new double[x][y];
        for (int i = 0; i < x; i++) {
            for (int j = 0; j < y; j++) {
                result[i][j] = m * random.nextGaussian();
            }
        }
        return result;
    }
}