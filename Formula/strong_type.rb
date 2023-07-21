class StrongType < Formula
  desc "Additive strong typedef library for C++14/17/20"
  homepage "https://github.com/rollbear/strong_type"
  url "https://github.com/rollbear/strong_type/archive/refs/tags/v12.tar.gz"
  sha256 "8af0400c7ae76c7ec8646e929bacb37fc7fcae33e54eeaa61fa9f9df508a9248"
  license "BSL-1.0"

  bottle do
    root_url "https://github.com/a4z/homebrew-cpp-taps/releases/download/strong_type-11"
    sha256 cellar: :any_skip_relocation, ventura:      "6bf297f3c01649f4db35df2d75e1c21de9503d13de75d6b707a7347c9ce65851"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4b88b4552674ae052befa8e32fad1b1610a0b735e81da8d60ebc2de4347d18e2"
  end

  depends_on "cmake" => :build

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <strong_type/strong_type.hpp>
      int main() {
        strong::type<int, struct Tag> i{42};
        if (value_of(i) == 42)
          return 0;
        return 1;
      }
    EOS
    system ENV.cxx, "test.cpp", "-std=c++14", "-o", "test"
    system "./test"
  end
end
