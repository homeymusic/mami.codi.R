test_that('form looks good',{
  P1 = c(60) %>% mami.codi()
  expect_true(P1$consonance_dissonance > 0)
})
