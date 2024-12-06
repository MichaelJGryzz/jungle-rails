describe("Add_to_cart", () => {
  it("should visit root", () => {
    cy.visit("/");
  });

  it("should click on one of the 'Add to Cart' buttons and increases the cart count by 1", () => {
    cy.visit("/");
    cy.contains("My Cart (0)");
    cy.contains("Add").click({ force: true });
    cy.contains("My Cart (1)");
  });
});
