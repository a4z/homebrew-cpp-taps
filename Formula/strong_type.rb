class StrongType < Formula
  desc "Additive strong typedef library for C++14/17/20"
  homepage "https://github.com/rollbear/strong_type"
  url "https://github.com/rollbear/strong_type/archive/refs/tags/v10.tar.gz"
  sha256 "154e4ceda6cf8fe734deb7eafdf58df5052822d04425dc7c22711ef54cdaeefa"
  license "BSL-1.0"

  depends_on "cmake" => :build

  bottle do
    sha256 cellar: :any_skip_relocation, all: "016556278cd2880486c4fd1f15918c5561c8034a69c66d80f5a7c9f813381fe1"
  end

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
