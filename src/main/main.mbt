fn main {
  let n = 6
  let s = 10
  let t = 8
  let ass = [
    [1000, 1000, -1000, -1000],
    [1000, -1000, -1000, -1000],
    [-1000, 1000, 1000, 1000],
    [-1000, 1000, -1000, -1000],
    [1000, 1000, 1000, -1000],
    [1000, -1000, -1000, 1000],
  ]
  println(solve(n, s, t, ass))
}

fn solve(n : Int, s : Int, t : Int, ass : Array[Array[Int]]) -> Float {
  let ns = []
  for i in 0..<n {
    ns.push(i)
  }
  let mut min_distance : Float = @float.max_value
  let mut exp = 1
  for i in 0..<n {
    exp = exp * 2
  }
  while true {
    for bit = 0; bit < exp; bit = bit + 1 {
      let mut distance : Float = 0
      let mut tmp_x = 0
      let mut tmp_y = 0
      for index, elm in ns {
        let mut b = get_nth_bit(bit, index)
        distance = distance +
          calc_distance(tmp_x, tmp_y, ass[elm][2 * b], ass[elm][2 * b + 1]) /
          s.to_float()
        tmp_x = ass[elm][2 * b]
        tmp_y = ass[elm][2 * b + 1]
        b = 1 - b
        distance = distance +
          calc_distance(tmp_x, tmp_y, ass[elm][2 * b], ass[elm][2 * b + 1]) /
          t.to_float()
        tmp_x = ass[elm][2 * b]
        tmp_y = ass[elm][2 * b + 1]
      }
      if distance < min_distance {
        min_distance = distance
      }
    }
    if not(next_permutation(ns)) {
      break
    }
  }
  min_distance
}

fn calc_distance(x1 : Int, y1 : Int, x2 : Int, y2 : Int) -> Float {
  ((x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1)).to_float().sqrt()
}

fn get_nth_bit(num : Int, n : Int) -> Int {
  (num >> n) & 1
}

fn next_permutation(ns : Array[Int]) -> Bool {
  let n = ns.length()
  for i = n - 2; i >= 0; i = i - 1 {
    if ns[i] < ns[i + 1] {
      for j = n - 1; j >= i + 1; j = j - 1 {
        if ns[i] < ns[j] {
          let mut tmp = ns[i]
          ns[i] = ns[j]
          ns[j] = tmp
          let mut p = i + 1
          let mut q = n - 1
          while p < q {
            tmp = ns[p]
            ns[p] = ns[q]
            ns[q] = tmp
            p = p + 1
            q = q - 1
          }
          return true
        }
      }
    }
  }
  false
}
