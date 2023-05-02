class StrongType < Formula
  desc "Additive strong typedef library for C++14/17/20"
  homepage "https://github.com/rollbear/strong_type"
  url "https://github.com/rollbear/strong_type/archive/refs/tags/v10.tar.gz"
  sha256 "154e4ceda6cf8fe734deb7eafdf58df5052822d04425dc7c22711ef54cdaeefa"
  license "BSL-1.0"

  bottle do
    root_url "https://github.com/a4z/homebrew-cpp-taps/releases/download/strong_type-10"
    rebuild 2
    sha256 cellar: :any_skip_relocation, ventura:      "98329c8256c6d5300e24fbbbe9cef7d894f67c103ec14ec5f4eb818695d6cb28"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "c075a2854ff35298914ced71404c7a0d15cc51b5fc00d4b8f4497dbee4f17d65"
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
