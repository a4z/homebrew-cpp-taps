class Mdspan < Formula
  desc "Reference mdspan implementation"
  homepage "https://github.com/kokkos/mdspan"
  url "https://github.com/kokkos/mdspan.git", revision: "bca0e55"
  version "0.6.1-git"
  license "Apache-2.0" => { with: "LLVM-exception" }

  def install
    cp_r "include/.", include.to_s
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <mdspan/mdspan.hpp>
      #include <iostream>
      #include <array>
      int main() {
        std::array<int, 9> d{
          0, 5, 1,
          3, 8, 4,
          2, 7, 6,
        };

        Kokkos::mdspan m{d.data(), Kokkos::extents{3, 3}};
        for (std::size_t i = 0; i < m.extent(0); ++i)
          for (std::size_t j = 0; j < m.extent(1); ++j)
            std::cout << "m(" << i << ", " << j << ") == " << m(i, j) << std::endl;
      }
    EOS
    system ENV.cxx, "test.cpp", "-std=c++17", "-o", "test"
    system "./test"
  end
end
