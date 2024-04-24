import { BrowserRouter, Route, Routes } from "react-router-dom"
import HomeClientPage from "./pages/client/HomeClientPage"
import LoginPage from "./pages/general/LoginPage"

function App() {
  return (
    <BrowserRouter>
    <Routes>
      
        <Route  path="/*" element={<LoginPage />} />
        <Route path="inicio-cliente" element={<HomeClientPage />}/>

    </Routes>
    </BrowserRouter>
  )
}
export default App
