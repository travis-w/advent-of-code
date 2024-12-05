import gleam/int
import gleam/io
import gleam/list
import gleam/string
import gleam/string_tree
import simplifile.{read}

pub fn main() {
  let assert Ok(contents) = read("input.txt")

  let part_one =
    string.split(contents, on: "\n")
    |> list.map(fn(val) {
      let string_split = string.split(val, on: "   ")

      case string_split {
        [first, second] -> {
          let assert Ok(num_a) = int.base_parse(first, 10)
          let assert Ok(num_b) = int.base_parse(second, 10)
          #(num_a, num_b)
        }
        _ -> #(0, 0)
      }
    })
    |> list.unzip()
    |> fn(a) {
      let #(group_one, group_two) = a

      list.zip(
        list.sort(group_one, int.compare),
        list.sort(group_two, int.compare),
      )
    }
    |> list.fold(0, fn(acc, cur) {
      let #(a, b) = cur
      let diff = a - b

      acc + int.absolute_value(diff)
    })

  let part_two =
    string.split(contents, on: "\n")
    |> list.map(fn(val) {
      let string_split = string.split(val, on: "   ")

      case string_split {
        [first, second] -> {
          let assert Ok(num_a) = int.base_parse(first, 10)
          let assert Ok(num_b) = int.base_parse(second, 10)
          #(num_a, num_b)
        }
        _ -> #(0, 0)
      }
    })
    |> list.unzip()
    |> fn(a) {
      let #(group_one, group_two) = a

      list.fold(group_one, 0, fn(acc, cur) {
        acc + cur * list.count(group_two, fn(val) { val == cur })
      })
    }

  string_tree.new()
  |> string_tree.append("Part one: ")
  |> string_tree.append(int.to_string(part_one))
  |> string_tree.append("\nPart two: ")
  |> string_tree.append(int.to_string(part_two))
  |> string_tree.to_string()
  |> io.println()
}
