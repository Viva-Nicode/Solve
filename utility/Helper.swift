extension String {
    subscript(_ index: Int) -> Self {
        Self(self[self.index(self.startIndex, offsetBy: index)])
    }
}
