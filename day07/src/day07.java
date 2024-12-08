
import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

public static void main(String[] args) throws IOException {
    var input = prepare(args[1]);
    System.out.println("Part 1: "+ part1(input));
    System.out.println("Part 2: "+ part2(input));
}

private static ArrayList<ArrayList<Integer>> prepare(String path) throws IOException {
    ArrayList<ArrayList<Integer>> input = new ArrayList<>();

    try (BufferedReader br = new BufferedReader(new FileReader("file.txt"))) {
        String line = br.readLine();

        while (line != null) {
            input.add(new ArrayList<>(
                    Arrays.stream(line.split(":? ")).map(Integer::valueOf).collect(Collectors.toList())));
        }
    }
    return input;
}

private static int part1(ArrayList<ArrayList<Integer>> input) {
    var result = 0;
    for (ArrayList<Integer> equation : input) {
        
    }
    return result;
}


private static int part2(ArrayList<ArrayList<Integer>> input) {
    var result = 0;

    return result;
}