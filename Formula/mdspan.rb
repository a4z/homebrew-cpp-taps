class Mdspan < Formula
  desc "Reference mdspan implementation"
  homepage "https://github.com/kokkos/mdspan"
  url "https://github.com/kokkos/mdspan/archive/refs/tags/mdspan-0.6.0.tar.gz"
  sha256 "79f94d7f692cbabfbaff6cd0d3434704435c853ee5087b182965fa929a48a592"
  license "Apache-2.0" => { with: "LLVM-exception" }

  depends_on "python3" => :build

  def install
    include_dir = "#{include}/mdspan"
    mkdir_p include_dir
    system "./make_single_header.py ./include/experimental/mdarray > mdspan.hpp"
    include.install "mdspan.hpp" => "mdspan/"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <mdspan/mdspan.hpp>
      #include <iostream>
      #include <array>
      int main() {
        std::array<int> d{
          0, 5, 1,
          3, 8, 4,
          2, 7, 6,
        };

        Kokkos::mdspan m{d.data(), Kokkos::extents{3, 3}};
        for (std::size_t i = 0; i < m.extent(0); ++i)
          for (std::size_t j = 0; j < m.extent(1); ++j)
            std::cout << "m(" << i << ", " << j << ") == " << m(i, j) << "\n";
      }
    EOS
    system ENV.cxx, "test.cpp", "-std=c++17", "-o", "test"
    system "./test"
  end
end
