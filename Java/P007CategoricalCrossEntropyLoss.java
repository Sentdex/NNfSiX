public class P007CategoricalCrossEntropyLoss {
  public static void main(String[] args) {
    double[] softmaxOutput = new double[] { 0.7, 0.1, 0.2 };
    double[] targetOutput = new double[] { 1, 0, 0 };

    double loss = -(
      (Math.log(softmaxOutput[0]) * targetOutput[0]) +
      (Math.log(softmaxOutput[1]) * targetOutput[1]) +
      (Math.log(softmaxOutput[2]) * targetOutput[2])
    );

    System.out.println(loss);

    System.out.println(-Math.log(0.7));
    System.out.println(-Math.log(0.5));
  }
}
